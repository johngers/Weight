//
//  WeightAMinuteiOSApp.swift
//  WeightAMinuteiOS
//
//  Created on 3/25/23.
//

import SwiftUI
import WeightiOS

@main
struct WeightAMinuteiOSApp: App {
    @State var shouldShowInputSheet: Bool = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                HomeTabsView(showInput: {
                    shouldShowInputSheet = true
                })
                .ignoresSafeArea(.keyboard)

                if shouldShowInputSheet {
                    VStack {
                        Spacer()
    
                        ValueInputView(viewModel: ValueInputViewModel(close: {
                            shouldShowInputSheet = false
                        }, confirm: {
                            shouldShowInputSheet = false
                            print("Confirmed input")
                        }))
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.5).onTapGesture {
                        shouldShowInputSheet = false
                    }.ignoresSafeArea())
                    .transition(.asymmetric(insertion: .opacity.animation(.easeIn(duration: 0.25)), removal: .opacity.animation(.easeOut(duration: 0.25))))
                }
            }
        }
    }
}
