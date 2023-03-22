//
//  ImageCacheManager.swift
//  DynamicMons
//
//  Created by Mateus Lino on 20/12/22.
//

import Nuke
import UIKit

protocol ImageCacheManagerProtocol {
    func image(for url: URL) async throws -> UIImage
}

protocol ImagePipelineProtocol {
    func image(for url: URL) async throws -> UIImage
}

final class ImageCacheManager: ImageCacheManagerProtocol {
    private let imagePipeline: ImagePipelineProtocol

    init(imagePipeline: ImagePipelineProtocol = ImagePipeline()) {
        self.imagePipeline = imagePipeline
    }

    func image(for url: URL) async throws -> UIImage {
        return try await imagePipeline.image(for: url)
    }
}

extension ImagePipeline: ImagePipelineProtocol {
    func image(for url: URL) async throws -> UIImage {
        return try await self.image(for: url).image
    }
}
