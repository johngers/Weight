//
//  WeightItemStoreSpy.swift
//  WeightTests
//
//  Created on 4/15/23.
//

import Foundation
import Weight

final class WeightItemStoreSpy: WeightItemStore {
    enum ReceivedMessage: Equatable {
        case deleteCachedItem
        case save(LocalWeightItem)
        case retrieve
    }

    private(set) var receivedMessages: [ReceivedMessage] = []
    
    private var deletionCompletions = [DeletionCompletion]()
    private var saveCompletions: [SaveCompletion] = []
    private var retrievalCompletions: [RetrievalCompletion] = []
    
    func deleteCachedItem(completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedMessages.append(.deleteCachedItem)
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

    func save(_ item: LocalWeightItem, completion: @escaping SaveCompletion) {
        receivedMessages.append(.save(item))
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
    
    func completeRetrieval(with item: LocalWeightItem, at index: Int = 0) {
        retrievalCompletions[index](.success(item))
    }
}
