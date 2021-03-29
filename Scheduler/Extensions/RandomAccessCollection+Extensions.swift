//
//  RandomAccessCollection+Extensions.swift
//  Scheduler
//
//  Created by Одинцов Александр Александрович on 27.03.2021.
//

import Foundation

extension RandomAccessCollection {
    subscript(at index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}
