//
//  LandingView.swift
//  DynamicMons
//
//  Created by Mateus Lino on 10/12/22.
//

import ComposableArchitecture
import SwiftUI

struct LandingView: View {
    let store: Store<LandingState, LandingAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading, spacing: Spacing.main.large) {}
            .navigationBar(isHidden: true)
            .onAppear {
                viewStore.send(.fetchData)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LandingView(
                store: Store(
                    initialState: LandingState(),
                    reducer: landingReducer,
                    environment: LandingEnvironment.preview
                )
            )
        }
    }
}
