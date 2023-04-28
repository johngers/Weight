//
//  ValueInputView.swift
//  WeightiOS
//
//  Created on 4/27/23.
//

import SwiftUI

public class ValueInputViewModel: ObservableObject {
    @Published var input: String = ""
    let close: () -> Void
    let confirm: () -> Void
    
    public init(close: @escaping () -> Void, confirm: @escaping () -> Void) {
        self.close = close
        self.confirm = confirm
    }
}

public struct ValueInputView: View {
    @ObservedObject var viewModel: ValueInputViewModel
    
    public init(viewModel: ValueInputViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.close()
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
    
                TextField("0.0", text: $viewModel.input)
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                
                SegmentedPickerView(options: [.lb, .kg])
                    .frame(width: 100)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 25)
        
            ActionButtonView(isEnabled: true, title: "Enter", color: .systemMint.withAlphaComponent(0.5), buttonSelection: viewModel.confirm)
                .frame(width: 200)
        }
        .padding()
    }
}

struct ValueInputView_Previews: PreviewProvider {
    static var previews: some View {
        ValueInputView(viewModel: ValueInputViewModel(close: { }, confirm: { }))
            .previewLayout(.sizeThatFits)
    }
}
