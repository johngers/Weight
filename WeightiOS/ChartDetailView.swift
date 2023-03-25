//
//  ChartDetailView.swift
//  WeightiOS
//
//  Created by John Gers on 3/24/23.
//

import Charts
import SwiftUI
import Weight

struct ChartDetailView: View {
    let weightData = ChartState()
    let color: Color
    
    init(color: Color = .mint.opacity(0.5)) {
        self.color = color
    }

    var body: some View {
        VStack(alignment: .leading) {
            SegmentedPickerView(selectedUnit: .lb, options: [.lb, .kg, .calories])

            Spacer()
                .frame(height: 20)

            Chart(weightData.weightData) { weightItem in
                PointMark(
                    x: .value("Day", weightItem.date, unit: .day),
                    y: .value("Weight", weightItem.weight)
                )
                .foregroundStyle(color)
                
                LineMark(
                    x: .value("Day", weightItem.date, unit: .day),
                    y: .value("Weight", weightItem.weight)
                )
                .lineStyle(StrokeStyle(lineWidth: 1))
                .foregroundStyle(color)
            }
            .chartYScale(domain: weightData.sortedData.first!.weight...weightData.sortedData.last!.weight)
        }
        .padding()
        .padding(.top, 50)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDetailView()
            .previewLayout(.sizeThatFits)
    }
}
