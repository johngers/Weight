//
//  WeightLogStoreSpy.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import Foundation
import Weight

final class WeightLogStoreSpy: WeightLogStore {
    enum ReceivedMessage: Equatable {
        case save([LocalWeightItem])
        case retrieve
    }

    private(set) var receivedMessages: [ReceivedMessage] = []
    private var saveCompletions: [SaveCompletion] = []
    
    func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion) {
        receivedMessages.append(.save(log))
        saveCompletions.append(completion)
    }
    
    func retrieve() {
        receivedMessages.append(.retrieve)
    }
}
