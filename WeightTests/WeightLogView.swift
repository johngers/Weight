//
//  WeightLogView.swift
//  Weight
//
//  Created by John Gers on 3/17/23.
//

import SwiftUI

struct WeightLogView: View {
    let weightLog: [WeightItem] = [
        .init(id: .init(),
              weight: 100,
              date: .now)
    ]

    var body: some View {
        NavigationView {
            ContentView(weightLog: weightLog)
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

private struct ContentView: View {
    let weightLog: [WeightItem]
    let selectionAction: () -> Void = { }
    let deleteAction: () -> Void = { }

    var body: some View {
        List(weightLog) { item in
            LogItemView(weightItem: item, deleteAction: deleteAction)
                .onTapGesture {
                    selectionAction()
                }
        }
    }
}

private struct LogItemView: View {
    let weightItem: WeightItem
    let deleteAction: () -> Void
    
    var body: some View {
        HStack {
            Text(String(weightItem.weight))
            
            Spacer()
            
            Text(weightItem.date.description)
                .foregroundColor(.secondary)
        }
        .swipeActions(edge: .trailing) {
            DeleteButtonView(deleteAction: deleteAction)
        }
    }
}

private struct DeleteButtonView: View {
    let deleteAction: () -> Void

    var body: some View {
        Button(action: deleteAction) {
          Label("Delete", systemImage: "trash")
        }
        .tint(Color(UIColor.systemRed))
    }
}

struct WeightLogView_Previews: PreviewProvider {
    static var previews: some View {
        WeightLogView()
    }
}
