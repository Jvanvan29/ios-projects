//
//  HomeView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ActivityKit
import ComposableArchitecture
import SwiftUI
import WidgetKit

struct HomeView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                ScrollView {
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ]
                    LazyVGrid(columns: columns, spacing: Spacing.main.regular) {
                        ForEach(
                            Array(viewStore.mons.enumerated()),
                            id: \.offset
                        ) { index, mon in
                            MonView(
                                level: mon.level,
                                imageURL: mon.imageURL,
                                title: mon.name,
                                experienceProgress: mon.experienceProgress
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, Spacing.main.regular)
            }
            .navigationBar(isHidden: false, title: "Pokémon", titleDisplayMode: .large)
            .background(AppColor.main.customBackground)
            .onAppear {
                viewStore.send(.fetchData)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(
                store: Store(
                    initialState: HomeState(mons: [
                        Mon(
                            id: nil,
                            imageURL: URL(string: "https://serebii.net/pokemongo/pokemon/004.png")!,
                            sprite: URL(string: "https://img.pokemondb.net/sprites/sword-shield/normal/charmander.png")!,
                            name: "Charmander",
                            type: .fire,
                            experience: 640
                        ),
                        Mon(
                            id: nil,
                            imageURL: URL(string: "https://serebii.net/pokemongo/pokemon/001.png")!,
                            sprite: URL(string: "https://img.pokemondb.net/sprites/sword-shield/normal/bulbasaur.png")!,
                            name: "Bulbasaur",
                            type: .grass
                        ),
                        Mon(
                            id: nil,
                            imageURL: URL(string: "https://serebii.net/pokemongo/pokemon/001.png")!,
                            sprite: URL(string: "https://img.pokemondb.net/sprites/sword-shield/normal/bulbasaur.png")!,
                            name: "Bulbasaur",
                            type: .grass
                        )
                    ]),
                    reducer: homeReducer,
                    environment: HomeEnvironment.preview
                )
            )
        }
    }
}

