//
//  ValueInputView.swift
//  WeightiOS
//
//  Created on 4/27/23.
//

import SwiftUI

struct ValueInputView: View {
    @Binding var input: String
    let close: () -> Void
    let confirm: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                        .font(.title2)
                }

                Spacer()
            }
            
            Spacer()
                .frame(height: 25)
            
            HStack {
                Spacer()
    
                TextField(text: $input, label: {
                    Text(input)
                })
                .font(.title)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                
                SegmentedPickerView(options: [.lb, .kg])
                    .frame(width: 100)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 25)
        
            ActionButtonView(isEnabled: true, title: "Enter", color: .systemMint.withAlphaComponent(0.5), buttonSelection: confirm)
                .frame(width: 200)
        }
        .padding()
    }
}

struct ValueInputView_Previews: PreviewProvider {
    static var previews: some View {
        ValueInputView(input: .constant("0.0"), close: { }, confirm: { })
            .previewLayout(.sizeThatFits)
    }
}
