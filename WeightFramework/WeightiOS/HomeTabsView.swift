//
//  HomeTabsView.swift
//  WeightiOS
//
//  Created on 3/19/23.
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

public struct HomeTabsView: View {
    var tabs: [Tab] = [.weight, .steps, .calories]
    @State var currentTab: Tab = .weight
    
    let showInput: () -> Void
    
    public init(showInput: @escaping () -> Void) {
        self.showInput = showInput
    }

    public var body: some View {
        VStack {
            HomeTabHeader(currentTab: currentTab)

            TabView(selection: $currentTab) {
                ForEach(tabs) { tab in
                    switch tab {
                    case .weight:
                        WeightInputView(showInput: showInput)
                            .tag(tab)
                    case .steps:
                        StepsInputView()
                            .tag(tab)
                    case .calories:
                        CaloriesInputView()
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
}

private struct HomeTabHeader: View {
    let currentTab: Tab

    var body: some View {
        switch currentTab {
        case .weight:
            TabHeaderView(imageName: "scalemass", lastUpdated: "Last updated: March 19th", title: "Statistics", tabTitle: "Weight", color: .systemMint, selectedUnit: .lb, settingsSelection: { })
                .padding()
        case .steps:
            TabHeaderView(imageName: "figure.walk", lastUpdated: "Last updated: March 19th", title: "Statistics", tabTitle: "Steps", units: [.miles, .kilometer], color: .systemPurple, selectedUnit: .miles, settingsSelection: { })
                .padding()
        case .calories:
            TabHeaderView(imageName: "fork.knife", lastUpdated: "Last updated: March 19th", title: "Statistics", tabTitle: "Calories", units: [.calories], color: .systemGreen, selectedUnit: .calories, settingsSelection: { })
                .padding()
        }
    }
}

struct HomeTabsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabsView(showInput: { })
            .previewLayout(.sizeThatFits)
    }
}
