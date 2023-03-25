//
//  InputView.swift
//  WeightiOS
//
//  Created by John Gers on 3/25/23.
//

import SwiftUI

struct InputView: View {

    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Input type")
                .fontWeight(.semibold)

            Spacer()
                .frame(height: 25)
    
            StepperView()
            
            Spacer()
                .frame(height: 25)
            
            SegmentedPickerView(options: [.lb, .kg])
                .frame(width: 100)
            
            Spacer()
        
            ActionButtonView(isEnabled: true, title: "Enter", color: .systemMint.withAlphaComponent(0.5), buttonSelection: { })
                .frame(width: 200)
        }
        .padding()
    }
}

private struct StepperView: View {
    @State var inputWeight: String = "100.0"

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
    
            Button(action: {
                
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(.mint.opacity(0.5))
            })

            TextField("Text", text: $inputWeight)
                .frame(width: 75)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
                .font(.title)

            Button(action: {
                
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.mint.opacity(0.5))
            })

            Spacer()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

