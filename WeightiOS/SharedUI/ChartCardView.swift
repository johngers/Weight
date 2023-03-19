//
//  ChartCardView.swift
//  WeightiOS
//
//  Created by John Gers on 3/18/23.
//

import Charts
import SwiftUI
import Weight

struct ChartCardView: View {
    let weightData = ChartState()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Last 30 days")
                .fontWeight(.semibold)

            Chart(weightData.weightData) { weightItem in
                LineMark(
                    x: .value("Day", weightItem.date, unit: .day),
                    y: .value("Weight", weightItem.weight)
                )
                .lineStyle(StrokeStyle(lineWidth: 5))
                .foregroundStyle(.mint.opacity(0.5))
            }
            .chartYScale(domain: weightData.sortedData.first!.weight...weightData.sortedData.last!.weight)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
            HStack {
                Text(weightData.sortedData.first!.date.formatted(.dateTime.month(.wide).day()))
                    .fontWeight(.medium)
                
                Spacer()
                
                Text(weightData.sortedData.last!.date.formatted(.dateTime.month(.wide).day()))
                    .fontWeight(.medium)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}

struct ChartCardView_Previews: PreviewProvider {
    static var previews: some View {
        ChartCardView()
            .previewLayout(.sizeThatFits)
    }
}