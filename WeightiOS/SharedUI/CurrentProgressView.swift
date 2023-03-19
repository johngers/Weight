//
//  CurrentProgressView.swift
//  WeightiOS
//
//  Created by John Gers on 3/19/23.
//

import SwiftUI

struct CurrentProgressView: View {
    @State private var progressAmount = 0.5

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Spacer()
                
                Text("Goal")
                    .fontWeight(.heavy)
                
                Text("100 lb")
        
                Spacer()
                    .frame(height: 50)
                
                Text("Current")
                    .fontWeight(.heavy)
                
                Text("75 lb")
                
                Spacer()
            }
            .padding(125)
            .background {
                CircularProgressView(progress: progressAmount, color: .mint.opacity(0.5))
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
