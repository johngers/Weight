//
//  StepsInputView.swift
//  WeightiOS
//
//  Created on 3/19/23.
//

import SwiftUI

struct StepsInputView: View {

    var body: some View {
        VStack {
            
            Spacer()
                .frame(height: 25)
            
            Spacer()

            CurrentProgressView(current: "1000", goal: "10000", color: .purple.opacity(0.5))
            
            Spacer()
            
            BarChartCardView(color: .purple.opacity(0.5))
                .frame(height: 150)
        }
        .padding()
    }
}

struct StepsInputView_Previews: PreviewProvider {
    static var previews: some View {
        StepsInputView()
    }
}

