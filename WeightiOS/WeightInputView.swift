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
            TabHeaderView(imageName: "scalemass", title: "Statistics", tabTitle: "Weight", color: .systemMint, settingsSelection: { })
            
            Spacer()
                .frame(height: 50)
            
            DateView()
            
            Spacer()

            InputView()
            
            Spacer()
            
            ProgressCardView()
            
            ActionButtonView(isEnabled: true, title: "Enter", color: .systemMint.withAlphaComponent(0.5), buttonSelection: { })
                .frame(width: 200)
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

private struct DateView: View {
    @State var selectedDate: Date = .now

    var body: some View {
        HStack {
            Spacer()
            
            DatePicker(selection: $selectedDate, displayedComponents: .date) {
                Image(systemName: "calendar")
            }
            .frame(maxWidth: 150)
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 2)
            )
            
            Spacer()
        }
    }
}

struct WeightInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeightInputView()
    }
}

