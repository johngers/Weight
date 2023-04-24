//
//  WeightLogStoreSpy.swift
//  WeightTests
//
//  Created on 3/16/23.
//

import Foundation
import Weight

final class WeightLogStoreSpy: WeightLogStore {
    enum ReceivedMessage: Equatable {
        case deleteCachedLog
        case save([LocalWeightItem])
        case retrieve
    }

    private(set) var receivedMessages: [ReceivedMessage] = []
    
    private var deletionCompletions = [DeletionCompletion]()
    private var saveCompletions: [SaveCompletion] = []
    private var retrievalCompletions: [RetrievalCompletion] = []
    
    func deleteCachedLog(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCachedLog)
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
        deletionCompletions[index](.failure(error))
    }
    
    func completeDeletionSuccessfully(at index: Int = 0) {
        deletionCompletions[index](.success(()))
    }
    
    func completeDeletionWithEmptyCache(at index: Int = 0) {
        deletionCompletions[index](.success(()))
    }

    func save(_ log: [LocalWeightItem], completion: @escaping SaveCompletion) {
        receivedMessages.append(.save(log))
        saveCompletions.append(completion)
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        receivedMessages.append(.retrieve)
        retrievalCompletions.append(completion)
    }
    
    func completeRetrieval(with error: Error, at index: Int = 0) {
        retrievalCompletions[index](.failure(error))
    }
    
    func completeRetrievalWithEmptyCache(at index: Int = 0) {
        retrievalCompletions[index](.success(.none))
    }
    
    func completeRetrieval(with log: [LocalWeightItem], at index: Int = 0) {
        retrievalCompletions[index](.success(CachedLog(log)))
    }
}
