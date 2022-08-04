//
//  IObserve.swift
//  ICommon
//
//  Created by Harvey on 2022/8/3.
//

import Foundation

public extension NSObjectProtocol where Self: NSObject {
    func observe<Value>(
        _ keyPath: KeyPath<Self, Value>,
        onChange: @escaping (Value) -> ())
    -> NSKeyValueObservation {
        
        return observe(keyPath, options: [.initial, .new]) { _, change in
            guard let newValue = change.newValue else { return }
            onChange(newValue)
        }
    }

    func bind<Value, Target>(
        _ sourceKeyPath: KeyPath<Self, Value>,
        to target: Target,
        at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> NSKeyValueObservation {
        return observe(sourceKeyPath) { target[keyPath: targetKeyPath] = $0 }
    }
}
