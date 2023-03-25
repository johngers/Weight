//
//  BarChartCardView.swift
//  WeightiOS
//
//  Created by John Gers on 3/24/23.
//

import Charts
import SwiftUI
import Weight

struct BarChartCardView: View {
    let weightData = ChartState()
    let color: Color
    
    init(color: Color = .mint.opacity(0.5)) {
        self.color = color
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Last 30 days")
                .fontWeight(.semibold)

            Chart(weightData.weightData) { weightItem in
                BarMark(
                    x: .value("Day", "\(weightItem.date.description)"),
                    y: .value("Weight", weightItem.weight)
                )
                .cornerRadius(8)
                .foregroundStyle(color)
                
                RuleMark(
                    y: .value("Goal", 105)
                )
                .lineStyle(StrokeStyle(lineWidth: 1))
                .foregroundStyle(.black)
                .annotation(position: .top, alignment: .trailing) {
                    Text("Goal: \(105, format: .number)")
                        .font(.title2)
                        .foregroundColor(.black)
                   
                }
            }
            .chartYScale(domain: 0.0...140.0)
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

struct BarChartCardView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartCardView()
            .previewLayout(.sizeThatFits)
    }
}
