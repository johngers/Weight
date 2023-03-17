//
//  WeightLoader.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public enum DeleteWeightResult {
    case success
    case failure(Error)
}

public protocol WeightLogLoader {
    typealias LoadResult = Result<[WeightItem], Error>

    func load(completion: @escaping (LoadResult) -> Void)
    func delete(completion: @escaping (DeleteWeightResult) -> Void)
}
