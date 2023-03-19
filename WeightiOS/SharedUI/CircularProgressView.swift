//
//  CircularProgressView.swift
//  WeightiOS
//
//  Created by John Gers on 3/19/23.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let color: Color
    
    init(progress: Double = 0.5, color: Color = .mint.opacity(0.5)) {
        self.progress = progress
        self.color = color
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: 30
                )

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeIn, value: progress)
        }
        .padding(20)
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
            .previewLayout(.sizeThatFits)
    }
}
