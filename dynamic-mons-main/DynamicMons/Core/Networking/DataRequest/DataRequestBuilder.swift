//
//  DataRequestBuilder.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

protocol DataRequestBuilderProtocol {
    func dataRequest(request: DataRequest) -> AnyPublisher<Data, Error>
    func signIn() -> AnyPublisher<Data, Error>
}

final class DataRequestBuilder: DataRequestBuilderProtocol {
    private let auth: Auth
    private let database: Firestore

    init(auth: Auth = Auth.auth(), database: Firestore = Firestore.firestore()) {
        self.auth = auth
        self.database = database
    }

    func dataRequest(request: DataRequest) -> AnyPublisher<Data, Error> {
        switch request.method {
        case .get:
            return getDataRequest(using: request)
        case .post:
            return postDataRequest(using: request)
        case .put:
            return updateDataRequest(using: request)
        case .delete:
            return deleteDataRequest(using: request)
        }
    }

    private func getDataRequest(using dataRequest: DataRequest) -> AnyPublisher<Data, Error> {
        if let documentID = dataRequest.documentID {
            return getDocument(from: dataRequest.route, documentID: documentID)
        } else {
            return getDocuments(from: dataRequest.route)
        }
    }

    private func getDocument(from route: String, documentID: String) -> AnyPublisher<Data, Error> {
        return database.collection(route).document(documentID)
            .tryMapToData(database: database)
            .eraseToAnyPublisher()
    }

    private func getDocuments(from route: String) -> AnyPublisher<Data, Error> {
        return database.collection(route).getDocuments()
            .map { snapshot -> [[String: Any]] in
                return snapshot.documents.map { $0.data() }
            }
            .flatMap { [unowned self] values in
                return self.documentsReferencesPublisher(from: values)
            }
            .tryMap { values in
                guard let data = try? JSONSerialization.data(withJSONObject: values, options: []) else {
                    throw NetworkError(status: .unableToParseResponse)
                }
                return data
            }
            .eraseToAnyPublisher()
    }

    private func documentsReferencesPublisher(from values: [[String: Any]]) -> AnyPublisher<[[String: Any]], Error> {
        var newValues = [[String: Any]]()
        let publishers = values.enumerated().map { index, dict in
            newValues.append([:])
            dict.forEach {
                guard !($0.value is DocumentReference) else { return }
                newValues[index][$0.key] = $0.value
            }
            let docPublishers = dict.documentReferencesPublishers(database: self.database)
                .map { publisher in
                    return publisher
                        .map { [index] result in
                            return (index, result.0, result.1)
                        }
                        .eraseToAnyPublisher()
                }
            return docPublishers
        }
        .flatMap { $0 }
        return documentsReferencesPublisher(from: publishers)
            .map { array in
                array.forEach {
                    newValues[$0.0][$0.1] = $0.2
                }
                return newValues
            }
            .eraseToAnyPublisher()
    }

    private func documentsReferencesPublisher(from publishers: [AnyPublisher<(Int, String, [String: Any]), Error>]) -> AnyPublisher<[(Int, String, [String: Any])], Error> {
        var publisher: AnyPublisher<[(Int, String, [String: Any])], Error> = publishers[0]
            .map { [$0] }
            .eraseToAnyPublisher()
        publishers
            .dropFirst()
            .forEach {
                publisher = publisher
                    .combineLatest($0)
                    .map {
                        var array = $0.0
                        array.append($0.1)
                        return array
                    }
                    .eraseToAnyPublisher()
            }
        return publisher
    }

    private func postDataRequest(using request: DataRequest) -> AnyPublisher<Data, Error> {
        return tryMapParameters(request.parameters)
            .flatMap { [document, database] parameters -> AnyPublisher<Data, Error> in
                let publisher: AnyPublisher<DocumentReference, Error>
                if let document = document(request) {
                    publisher = document.setData(parameters)
                        .map { document }
                        .eraseToAnyPublisher()
                } else {
                    publisher = database.collection(request.route).addDocument(data: parameters)
                        .eraseToAnyPublisher()
                }
                return publisher
                    .flatMap { [unowned self] in $0.tryMapToData(database: self.database) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    private func document(from request: DataRequest) -> DocumentReference? {
        guard let documentID = request.documentID else { return nil }
        return database.collection(request.route).document(documentID)
    }

    private func tryMapParameters(_ parameters: Parameters?) -> Result<Parameters, Error>.Publisher {
        return Just(parameters)
            .tryMap { parameters in
                guard let parameters = parameters else {
                    throw NetworkError(status: .unableToParseRequest)
                }
                return parameters
            }
    }

    private func updateDataRequest(using request: DataRequest) -> AnyPublisher<Data, Error> {
        return tryCompactMapDocumentID(request.documentID)
            .combineLatest(tryMapParameters(request.parameters))
            .flatMap { [database] documentID, parameters -> AnyPublisher<Data, Error> in
                let document = database.collection(request.route).document(documentID)
                return document.updateData(parameters)
                    .map { document }
                    .flatMap { [unowned self] in $0.tryMapToData(database: self.database) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    private func tryCompactMapDocumentID(_ documentID: String?) -> AnyPublisher<String, Error> {
        return Just(documentID)
            .tryCompactMap { $0 }
            .eraseToAnyPublisher()
    }

    private func deleteDataRequest(using dataRequest: DataRequest) -> AnyPublisher<Data, Error> {
        return tryCompactMapDocumentID(dataRequest.documentID)
            .flatMap { [database] documentID in
                return database.collection(dataRequest.route).document(documentID)
                    .delete()
            }
            .mapToEmptyData()
            .eraseToAnyPublisher()
    }

    func signIn() -> AnyPublisher<Data, Error> {
        return auth.signInAnonymously()
            .tryMap { response in try JSONEncoder().encode(response.user.uid) }
            .eraseToAnyPublisher()
    }
}

fileprivate extension DocumentReference {
    func tryMapToData(database: Firestore) -> AnyPublisher<Data, Error> {
        return getDocument()
            .tryCompactMap { $0.data() }
            .flatMap { dict in
                var dict = dict
                let publishers = dict.documentReferencesPublishers(database: database)
                    .map { publisher in
                        return publisher
                            .map {
                                return ($0.0, $0.1)
                            }
                            .eraseToAnyPublisher()
                    }
                return Publishers.MergeMany(publishers)
                    .map { newValue in
                        dict[newValue.0] = newValue.1
                        return dict
                    }
                    .eraseToAnyPublisher()
            }
            .tryMapDictionaryToData()
            .eraseToAnyPublisher()
    }
}

fileprivate extension Publisher where Output == [String: Any] {
    func tryMapDictionaryToData() -> Publishers.TryMap<Self, Data> {
        return tryMap { values -> Data in
            guard let jsonData = try? JSONSerialization.data(withJSONObject: values, options: []) else {
                throw NetworkError(status: .unableToParseResponse)
            }
            return jsonData
        }
    }
}

fileprivate extension Dictionary where Key == String, Value == Any {
    func documentReferencesPublishers(database: Firestore) -> [AnyPublisher<(String, [String: Any]), Error>] {
        var publishers = [AnyPublisher<(String, [String: Any]), Error>]()
        self.forEach { value in
            guard let ref = value.value as? DocumentReference else { return }
            let publisher = database.document(ref.path)
                .getDocument()
                .tryCompactMap { $0.data() }
                .map { (value.key, $0) }
                .eraseToAnyPublisher()
            publishers.append(publisher)
        }
        return publishers
    }
}

fileprivate extension Publisher {
    func mapToEmptyData() -> Publishers.Map<Self, Data> {
        return map { _ in
            return Data()
        }
    }
}
