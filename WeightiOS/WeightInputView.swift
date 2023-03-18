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
            
            EnterButtonView(isEnabled: true)
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

private struct ProgressCardView: View {
    @State private var downloadAmount = 50.0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Progress")
                .fontWeight(.bold)

            Spacer()
                .frame(height: 10)

            HStack {
                VStack(alignment: .leading) {
                    Text("Current")
                    
                    Text("75 lb")
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Goal")

                    Text("125 lb")
                        .fontWeight(.bold)
                }
            }

            ProgressView(value: downloadAmount, total: 100)
                .cornerRadius(8)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .progressViewStyle(.linear)
                .tint(.mint.opacity(0.5))

        }
        .padding()
        .background(Color.secondary.opacity(0.05))
        .cornerRadius(8)
    }
}

private struct EnterButtonView: View {
    let isEnabled: Bool
    var body: some View {
        Button(action: { }, label: {
            Text("Enter")
                .foregroundColor(isEnabled ? .white : .primary)
        })
        .padding()
        .frame(width: 200)
        .background(isEnabled ? Color.mint.opacity(0.5) : .secondary.opacity(0.2))
        .clipShape(Capsule())
        .disabled(!isEnabled)
    }
}

struct WeightInputView_Previews: PreviewProvider {
    static var previews: some View {
        WeightInputView()
    }
}

