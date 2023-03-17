//
//  WeightLoader.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public typealias LoadWeightResult = Result<[WeightItem], Error>

public enum DeleteWeightResult {
    case success
    case failure(Error)
}

protocol WeightLogLoader {
    func load(completion: @escaping (LoadWeightResult) -> Void)
    func delete(completion: @escaping (DeleteWeightResult) -> Void)
}
