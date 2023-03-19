//
//  WeightInputView.swift
//  Weight
//
//  Created by John Gers on 3/18/23.
//

import SwiftUI

struct WeightInputView: View {

    var body: some View {
        VStack {
            TabHeaderView(imageName: "scalemass", lastUpdated: "Last updated: March 19th", title: "Statistics", tabTitle: "Weight", color: .systemMint, settingsSelection: { })
            
            Spacer()
                .frame(height: 25)
            
            Spacer()

            CurrentProgressView()
            
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

private struct InputView: View {
    @State var selectedDate: Date = .now
    @State var inputWeight: String = "100.0"

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
    
            TextField("Text", text: $inputWeight)
                .frame(width: 75)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .font(.title)
    
            Text("lb")
                .font(.title)

            Spacer()
        }
    }
}

struct WeightInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeightInputView()
    }
}

