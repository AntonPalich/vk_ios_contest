//
//  Observable.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

public class Observable<T> {

    public init(_ value: T) {
        self.value = value
    }

    public var value: T {
        didSet {
            self.cleanDeadObservers()
            for observer in self.observers {
                observer.closure(oldValue, self.value)
            }
        }
    }

    public func observe(_ observer: AnyObject, closure: @escaping (_ old: T, _ new: T) -> Void) {
        self.observers.append(Observer(owner: observer, closure: closure))
        self.cleanDeadObservers()
    }

    private func cleanDeadObservers() {
        self.observers = self.observers.filter { $0.owner != nil }
    }

    private lazy var observers = [Observer<T>]()
}

private struct Observer<T> {
    weak var owner: AnyObject?
    let closure: (_ old: T, _ new: T) -> Void
    init (owner: AnyObject, closure: @escaping (_ old: T, _ new: T) -> Void) {
        self.owner = owner
        self.closure = closure
    }
}
