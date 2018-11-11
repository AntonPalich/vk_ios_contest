//
//  Observable.swift
//  VKContest
//
//  Created by Anton Schukin on 11/11/2018.
//  Copyright © 2018 Anton Shchukin. All rights reserved.
//

import Foundation

public class Observable<T> {

    private var _value: T

    public init(_ value: T) {
        self._value = value
    }

    public var value: T {
        get {
            return _value
        }
        set {
            self.setValue(newValue)
        }
    }

    public func setValue(_ value: T) {
        let oldValue = self._value
        self._value = value

        for observer in self.observers {
            observer.closure(oldValue, self.value)
        }
    }

    public func observe(_ closure: @escaping (_ old: T, _ new: T) -> Void) -> AnyObject {
        let observer = Observer(closure: closure)
        self.observers.append(observer)
        return ObserverWrapper(observer: observer, onDeinit: { [weak self] observer in
            self?.removeObserver(observer)
        })
    }

    fileprivate func removeObserver(_ observer: Observer<T>) {
        self.observers = self.observers.filter { $0 !== observer }
    }

    private lazy var observers = [Observer<T>]()
}

private class Observer<T> {
    let closure: (_ old: T, _ new: T) -> Void
    init (closure: @escaping (_ old: T, _ new: T) -> Void) {
        self.closure = closure
    }
}

private class ObserverWrapper<T> {
    let observer: Observer<T>
    let onDeinit: (Observer<T>) -> Void

    init(observer: Observer<T>, onDeinit: @escaping (Observer<T>) -> Void) {
        self.observer = observer
        self.onDeinit = onDeinit
    }

    deinit {
        self.onDeinit(self.observer)
    }
}
