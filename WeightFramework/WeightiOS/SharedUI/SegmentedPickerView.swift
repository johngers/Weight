//
//  SegmentedPickerView.swift
//  Weight
//
//  Created on 3/18/23.
//

import SwiftUI

enum WeightUnit: String, Identifiable {
    case lb = "lb"
    case kg = "kg"
    case steps = "steps"
    case miles = "mi"
    case kilometer = "km"
    case calories = "cal"
    
    var id: Self {
        return self
    }
}

struct SegmentedPickerView: View {
    @State var options: [WeightUnit]
    @State var selectedUnit: WeightUnit
    
    init(selectedUnit: WeightUnit = .lb, options: [WeightUnit] = [.lb, .kg], color: UIColor = .systemMint.withAlphaComponent(0.5)) {
        self.selectedUnit = selectedUnit
        self.options = options

        UISegmentedControl.appearance().selectedSegmentTintColor = color
    }

    var body: some View {
        Picker(selection: $selectedUnit, content: {
            ForEach(options) { option in
                Text(option.rawValue)
                    .tag(option)
            }
        }, label: {})
        .pickerStyle(.segmented)
    }
}

struct SegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerView()
            .previewLayout(.sizeThatFits)
    }
}
