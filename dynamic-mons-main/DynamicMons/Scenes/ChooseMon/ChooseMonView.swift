//
//  ChooseMonView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture
import SwiftUI

struct ChooseMonView: View {
    let store: Store<ChooseMonState, ChooseMonAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .center, spacing: Spacing.main.large) {
                Spacer()
                if let selectedMon = viewStore.selectedMon {
                    MonView(
                        level: selectedMon.level,
                        imageURL: selectedMon.imageURL,
                        title: selectedMon.name,
                        scale: .large
                    )
                    .padding(Spacing.main.regular)
                } else {
                    MonView
                        .skeleton()
                        .padding(Spacing.main.regular)
                        .redacted(reason: .placeholder)
                }
                Spacer()
                HStack(alignment: .center, spacing: Spacing.main.regular) {
                    Spacer()
                    ForEach(
                        Array(viewStore.starterMons.enumerated()),
                        id: \.offset
                    ) { index, _ in
                        MonBallView(
                            isSelected: viewStore.binding(
                                get: { state in
                                    return state.selectedMonIndex == index
                                },
                                send: ChooseMonAction.setSelectedMon(index: index)
                            )
                        )
                        .frame(height: 60)
                    }
                    Spacer()
                }
                Spacer()
                Button("I CHOOSE YOU!") { viewStore.send(.chooseMon) }
                    .buttonStyle(.standard(ofKind: .custom(color: viewStore.selectedMon?.type.color ?? Mon.MonType.fire.color)))
                    .padding(Spacing.main.regular)
            }
            .padding(.horizontal, Spacing.main.regular)
            .padding(.top, Spacing.main.extraLarge * 2)
            .background(AppColor.main.customBackground)
            .navigationBar(isHidden: true)
            .onAppear {
                viewStore.send(.fetchData)
            }
        }
    }
}

struct ChooseMonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseMonView(
                store: Store(
                    initialState: ChooseMonState(starterMons: [
                        Mon(
                            id: nil,
                            imageURL: URL(string: "https://serebii.net/pokemongo/pokemon/001.png")!,
                            sprite: URL(string: "https://img.pokemondb.net/sprites/sword-shield/normal/bulbasaur.png")!,
                            name: "Bulbasaur",
                            type: .grass,
                            experience: 0
                        ),
                        Mon(
                            id: nil,
                            imageURL: URL(string: "https://serebii.net/pokemongo/pokemon/004.png")!,
                            sprite: URL(string: "https://img.pokemondb.net/sprites/sword-shield/normal/charmander.png")!,
                            name: "Charmander",
                            type: .fire,
                            experience: 0
                        )
                    ]),
                    reducer: chooseMonReducer,
                    environment: ChooseMonEnvironment.preview
                )
            )
        }
    }
}
