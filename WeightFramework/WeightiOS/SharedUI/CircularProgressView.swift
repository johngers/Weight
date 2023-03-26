//
//  CircularProgressView.swift
//  WeightiOS
//
//  Created by John Gers on 3/19/23.
//

import SwiftUI

struct TripleCircularProgressView: View {
    var body: some View {
        ZStack {
            CircularProgressView(progress: 0.2, color: .mint.opacity(0.5))
                .frame(width: 150, height: 150)
            
            CircularProgressView(progress: 0.6, color: .purple.opacity(0.5))
                .frame(width: 210, height: 210)

            CircularProgressView(progress: 0.8, color: .green.opacity(0.5))
                .frame(width: 270, height: 270)
        }
    }
}

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

struct TripleCircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        TripleCircularProgressView()
            .previewLayout(.sizeThatFits)
    }
}


struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
            .previewLayout(.sizeThatFits)
    }
}
