//
//  CaloriesInputView.swift
//  WeightiOS
//
//  Created on 3/19/23.
//

import SwiftUI

struct CaloriesInputView: View {

    var body: some View {
        VStack {
            
            Spacer()
                .frame(height: 25)
            
            Spacer()

            CurrentProgressView(current: "1000", goal: "2000", color: .green.opacity(0.5))
            
            Spacer()
            
            BarChartCardView(color: .green.opacity(0.5))
                .frame(height: 150)
        }
        .padding()
    }
}

struct CaloriesInputView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesInputView()
    }
}

