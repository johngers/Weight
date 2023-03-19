//
//  HomeTabsView.swift
//  WeightiOS
//
//  Created by John Gers on 3/19/23.
//

import SwiftUI

// Tab idea: https://www.youtube.com/watch?v=uo8gj7RT3H8

enum Tab: Identifiable, Equatable {
    case weight
    case steps
    case calories
    
    var id: Self {
        return self
    }
}

struct HomeTabsView: View {
    var tabs: [Tab] = [.weight, .steps, .calories]
    @State var currentTab: Tab = .weight
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(tabs) { tab in
                switch tab {
                case .weight:
                    WeightInputView()
                        .tag(tab)
                case .steps:
                    WeightInputView()
                        .tag(tab)
                case .calories:
                    WeightInputView()
                        .tag(tab)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay (
            HStack(spacing: 15){
                ForEach(tabs) { tab in
                    Capsule()
                        .fill(Color.black)
                        .frame(width: tab == currentTab ? 20 : 7, height: 7)
                }
            }
            .padding(.bottom, 30)
            , alignment: .bottom
        )
    }
}

struct HomeTabsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabsView()
            .previewLayout(.sizeThatFits)
    }
}
