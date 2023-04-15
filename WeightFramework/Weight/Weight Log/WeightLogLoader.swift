//
//  WeightLoader.swift
//  Weight
//
//  Created by John Gers on 3/16/23.
//

import Foundation

public protocol WeightLogLoader {
    typealias LoadResult = Result<[WeightItem], Error>
    typealias DeleteResult = Result<Void, Error>
    
    func load(completion: @escaping (LoadResult) -> Void)
    func delete(completion: @escaping (DeleteResult) -> Void)
}
