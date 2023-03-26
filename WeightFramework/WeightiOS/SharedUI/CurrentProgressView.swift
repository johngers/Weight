//
//  CurrentProgressView.swift
//  WeightiOS
//
//  Created by John Gers on 3/19/23.
//

import SwiftUI

struct CurrentProgressView: View {
    @State private var progressAmount = 0.5
    let current: String
    let goal: String
    let color: Color
    
    init(progressAmount: Double = 0.5, current: String = "100 lb", goal: String = "75 lb", color: Color = .mint.opacity(0.5)) {
        self.progressAmount = progressAmount
        self.current = current
        self.goal = goal
        self.color = color
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Spacer()
                
                Text("Goal")
                    .fontWeight(.heavy)
                
                Text(goal)
        
                Spacer()
                    .frame(height: 50)
                
                Text("Current")
                    .fontWeight(.heavy)
                
                Text(current)
                
                Spacer()
            }
            .padding(125)
            .background {
                CircularProgressView(progress: progressAmount, color: color)
            }
        }
        .padding()
    }
}

struct CurrentProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentProgressView()
            .previewLayout(.sizeThatFits)
    }
}
