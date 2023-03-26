//
//  TabHeaderView.swift
//  WeightiOS
//
//  Created by John Gers on 3/18/23.
//

import SwiftUI

struct TabHeaderView: View {
    let image: String
    let lastUpdated: String
    let title: String
    let tabTitle: String
    let units: [WeightUnit]
    let color: UIColor
    let settingsSelection: () -> Void
    
    init(imageName: String, lastUpdated: String = "Last updated: March 19th", title: String, tabTitle: String, units: [WeightUnit] = [.lb, .kg], color: UIColor, settingsSelection: @escaping () -> Void) {
        self.image = imageName
        self.lastUpdated = lastUpdated
        self.title = title
        self.tabTitle = tabTitle
        self.units = units
        self.color = color
        self.settingsSelection = settingsSelection
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: image)
                    .font(.title)
                    .frame(width: 50, height: 50)
                    .background(Color(uiColor: color).opacity(0.5))
                    .cornerRadius(8)
                    .shadow(color: Color(uiColor: color).opacity(0.8), radius: 15, y: 30)
                
                Spacer()
                
                Text(lastUpdated)
                    .foregroundColor(.secondary)
                    
                Spacer()
                
                Button(action: settingsSelection, label: {
                    Image(systemName: "gear")
                        .font(.title)
                        .foregroundColor(.primary)
                })
            }
            
            Spacer()
                .frame(height: 30)

            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
    
                Text("•")
                    .fontWeight(.semibold)

                Text(tabTitle)
                    .fontWeight(.semibold)
                
                Spacer()

                SegmentedPickerView(options: units, color: color.withAlphaComponent(0.5))
                    .frame(width: 75)
            }
        }
    }
}

struct TabHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TabHeaderView(imageName: "scalemass", title: "Statistics", tabTitle: "Weight", color: .systemMint, settingsSelection: { })
            .previewLayout(.sizeThatFits)
    }
}

