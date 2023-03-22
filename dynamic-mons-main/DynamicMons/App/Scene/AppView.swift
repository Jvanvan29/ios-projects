//
//  AppView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: Store<AppState, AppAction>

    init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    var body: some View {
        SwitchStore(self.store) {
            CaseLet(state: /AppState.landing, action: AppAction.landing) { store in
                NavigationView {
                    LandingView(store: store)
                }
                .navigationViewStyle(.stack)
            }
            CaseLet(state: /AppState.chooseMon, action: AppAction.chooseMon) { store in
                NavigationView {
                    ChooseMonView(store: store)
                }
                .navigationViewStyle(.stack)
            }
            CaseLet(state: /AppState.home, action: AppAction.home) { store in
                NavigationView {
                    HomeView(store: store)
                }
                .navigationViewStyle(.stack)
            }
        }
    }
}
