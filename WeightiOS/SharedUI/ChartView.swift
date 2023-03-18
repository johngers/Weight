//
//  ChartView.swift
//  WeightiOS
//
//  Created by John Gers on 3/18/23.
//

import Charts
import SwiftUI
import Weight

// Chart animation https://www.youtube.com/watch?v=xS-fGYDD0qk

struct Weight: Identifiable {
    let id = UUID()
    let amount: Double
    let date: Date
}

let weightData: [Weight] = [.init(amount: 115.0, date: .now.adding(days: -1)), .init(amount: 100.0, date: .now), .init(amount: 125.0, date: .now.adding(days: 1))]

struct ChartView: View {

    var body: some View {
        Chart(weightData) { weightDataPoint in
            LineMark(
                x: .value("Day", weightDataPoint.date, unit: .day),
                y: .value("Weight", weightDataPoint.amount)
            )
            .foregroundStyle(.mint.opacity(0.5))
            
            RuleMark(
                y: .value("Average", 112)
            )
            .lineStyle(StrokeStyle(lineWidth: 1))
            .annotation(position: .top, alignment: .leading) {
                Text("Average: \(112, format: .number)")
                    .font(.headline)
                    .foregroundColor(.cyan)
            }
                
//            .symbol {
//                Image(systemName: "circle")
//                    .foregroundColor(.mint)
//            }
    
//            PointMark(
//                x: .value("Day", weightDataPoint.date, unit: .year),
//                y: .value("Weight", "Lbs")
//            )
//            .foregroundStyle(.mint.opacity(0.5))
        }
        .chartYScale(domain: 0...150)
        .chartYAxis {
            AxisMarks(preset: .extended, position: .leading)
        }
        // Use chart proxy to select certain values and get their x or y value

//        .chartPlotStyle { plotArea in
//            plotArea.background(.black)
//                .border(.orange)
//        }
//        .chartXAxis(.hidden)
//        .chartYAxis(.hidden)
        // Can be used to create custom grid marks
        //        .chartXAxis {
        //            // AxisMarks(values: .stride(by: .year))
        //        }

        // Can be used to only display marks for certain periods like every second month.
//        .chartXAxis {
//            AxisMarks(values: .stride(by: .year)) { value in
//                if value.as(Date.self) == .now {
//                    AxisGridLine().foregroundStyle(.black)
//                    AxisTick().foregroundStyle(.black)
//                    AxisValueLabel (
//                        format: .dateTime.year().quarter()
//                    )
//                } else {
//                    AxisGridLine()
//                }
//            }
//        }
        .frame(width: 300, height: 300)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .previewLayout(.sizeThatFits)
    }
}
