//
//  WeightLoader.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public enum LoadWeightResult {
    case success([WeightItem])
    case failure(Error)
}

protocol WeightLogLoader {
    func load(completion: @escaping (LoadWeightResult) -> Void)
}
