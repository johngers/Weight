//
//  WeightItemLoader.swift
//  Weight
//
//  Created by John Gers on 4/15/23.
//

import Foundation


public protocol WeightItemLoader {
    typealias LoadResult = Result<[WeightItem], Error>
    typealias DeleteResult = Result<Void, Error>
    
    func load(completion: @escaping (LoadResult) -> Void)
    func delete(completion: @escaping (DeleteResult) -> Void)
}
