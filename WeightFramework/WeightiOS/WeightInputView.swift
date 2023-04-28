//
//  WeightInputView.swift
//  Weight
//
//  Created on 3/18/23.
//

import SwiftUI

struct WeightInputView: View {
    let showInput: () -> Void
    
    var body: some View {
        VStack {
            
            Spacer()
                .frame(height: 25)
            
            Spacer()

            Button {
                // Empty so we disable the dim on click effect
            } label: {
                CurrentProgressView()
            }
            .disabled(true)
            .onTapGesture {
                showInput()
            }
            .foregroundColor(.primary)
            
            
            // TripleCircularProgressView()
            
            Spacer()
            
            ChartCardView()
                .frame(height: 150)
            
            // ProgressCardView()
            
//            ActionButtonView(isEnabled: true, title: "Enter", color: .systemMint.withAlphaComponent(0.5), buttonSelection: { })
//                .frame(width: 200)
        }
        .padding()
    }
}

struct WeightInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeightInputView(showInput: { })
    }
}

