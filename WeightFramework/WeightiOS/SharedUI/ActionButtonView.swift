//
//  ActionButtonView.swift
//  WeightiOS
//
//  Created on 3/18/23.
//

import SwiftUI

struct ActionButtonView: View {
    let isEnabled: Bool
    let title: String
    let color: UIColor
    let buttonSelection: () -> Void
    
    init(isEnabled: Bool = true, title: String = "Enter", color: UIColor = .systemMint.withAlphaComponent(0.5), buttonSelection: @escaping () -> Void) {
        self.isEnabled = isEnabled
        self.title = title
        self.color = color
        self.buttonSelection = buttonSelection
    }

    var body: some View {
        Button(action: buttonSelection, label: {
            Text(title)
                .foregroundColor(isEnabled ? .white : .primary)
        })
        .padding()
        .frame(maxWidth: .infinity)
        .background(isEnabled ? Color(uiColor: color) : .secondary.opacity(0.2))
        .clipShape(Capsule())
        .disabled(!isEnabled)
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(buttonSelection: { })
            .previewLayout(.sizeThatFits)
    }
}
