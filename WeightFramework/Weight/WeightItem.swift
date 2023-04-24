//
//  WeightItem.swift
//  Weight
//
//  Created on 3/16/23.
//

import Foundation

public struct WeightItem: Equatable, Identifiable {
    public let id: UUID
    public let weight: Double
    public let date: Date
    
    public init(id: UUID, weight: Double, date: Date) {
        self.id = id
        self.weight = weight
        self.date = date
    }
}

public struct ChartState {
    public let weightData: [WeightItem]
    
    public let sortedData: [WeightItem]
    
    public init(date: Date = .now) {
        self.weightData = [
            .init(id: .init(), weight: 100.0, date: date.adding(days: -30)),
            .init(id: .init(), weight: 101.0, date: date.adding(days: -29)),
            .init(id: .init(), weight: 102.0, date: date.adding(days: -28)),
            .init(id: .init(), weight: 103.0, date: date.adding(days: -27)),
            .init(id: .init(), weight: 104.0, date: date.adding(days: -26)),
            .init(id: .init(), weight: 105.0, date: date.adding(days: -25)),
            .init(id: .init(), weight: 105.0, date: date.adding(days: -24)),
            .init(id: .init(), weight: 106.0, date: date.adding(days: -23)),
            .init(id: .init(), weight: 107.0, date: date.adding(days: -22)),
            .init(id: .init(), weight: 108.0, date: date.adding(days: -21)),
            .init(id: .init(), weight: 109.0, date: date.adding(days: -20)),
            .init(id: .init(), weight: 110.0, date: date.adding(days: -19)),
            .init(id: .init(), weight: 111.0, date: date.adding(days: -18)),
            .init(id: .init(), weight: 112.0, date: date.adding(days: -17)),
            .init(id: .init(), weight: 113.0, date: date.adding(days: -16)),
            .init(id: .init(), weight: 114.0, date: date.adding(days: -15)),
            .init(id: .init(), weight: 115.0, date: date.adding(days: -14)),
            .init(id: .init(), weight: 116.0, date: date.adding(days: -13)),
            .init(id: .init(), weight: 117.0, date: date.adding(days: -12)),
            .init(id: .init(), weight: 118.0, date: date.adding(days: -11)),
            .init(id: .init(), weight: 119.0, date: date.adding(days: -10)),
            .init(id: .init(), weight: 120.0, date: date.adding(days: -9)),
            .init(id: .init(), weight: 121.0, date: date.adding(days: -8)),
            .init(id: .init(), weight: 122.0, date: date.adding(days: -7)),
            .init(id: .init(), weight: 123.0, date: date.adding(days: -6)),
            .init(id: .init(), weight: 124.0, date: date.adding(days: -5)),
            .init(id: .init(), weight: 125.0, date: date.adding(days: -4)),
            .init(id: .init(), weight: 126.0, date: date.adding(days: -3)),
            .init(id: .init(), weight: 127.0, date: date.adding(days: -2)),
            .init(id: .init(), weight: 128.0, date: date.adding(days: -1)),
            .init(id: .init(), weight: 129.0, date: date),
        ]
        
        sortedData = weightData.sorted(by: { $0.weight < $1.weight })
    }
}
