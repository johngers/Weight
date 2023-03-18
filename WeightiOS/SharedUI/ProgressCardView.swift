//
//  ProgressCardView.swift
//  WeightiOS
//
//  Created by John Gers on 3/18/23.
//

import SwiftUI

struct ProgressCardView: View {
    @State private var progressAmount = 50.0
    let currentText: String
    let goalText: String
    
    init(currentText: String = "75 lb", goalText: String = "125 lb") {
        self.currentText = currentText
        self.goalText = goalText
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Progress")
                .fontWeight(.bold)

            Spacer()
                .frame(height: 10)

            HStack {
                VStack(alignment: .leading) {
                    Text("Current")
                    
                    Text(currentText)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Goal")

                    Text(goalText)
                        .fontWeight(.bold)
                }
            }

            ProgressView(value: progressAmount, total: 100)
                .cornerRadius(8)
                .scaleEffect(x: 1, y: 2, anchor: .center)
                .progressViewStyle(.linear)
                .tint(.mint.opacity(0.5))

        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}

struct ProgressCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCardView()
            .previewLayout(.sizeThatFits)
    }
}
