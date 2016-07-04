//
//  Swignal.swift
//  Plug
//
//  Created by Joseph Neuman on 7/2/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation

class Swignal {
    
    private var swignalObservers: [SwignalObserver] = []
    
    internal func addSwignalObserver(swignalObserver: SwignalObserver) {
        purgeDeallocatedListeners()
        
        synced(self) {
            self.swignalObservers.append(swignalObserver)
        }
    }
    
    func removeObserver(observer: AnyObject) {
        synced(self) {
            for swignalObserver in self.swignalObservers {
                if swignalObserver.observer === observer {
                    self.swignalObservers.removeObject(swignalObserver)
                }
            }
        }
    }
    
    func removeAllObservers() {
        synced(self) {
            self.swignalObservers.removeAll()
        }
    }
    
    func handleFire(args:AnyObject...) {
        purgeDeallocatedListeners()
        
        synced(self) {
            for swignalObserver in self.swignalObservers {
                if swignalObserver.observer != nil {
                    swignalObserver.handleFire(args)
                }
            }
        }
    }
    
    private func purgeDeallocatedListeners() {
        synced(self) {
            for swignalObserver in self.swignalObservers {
                if swignalObserver.observer == nil {
                    self.removeObserver(swignalObserver)
                }
            }
        }
    }
}

// MARK: Type Confirmation
extension Swignal {
    
    static func typeConfirmation<L>(listener listener: (object: AnyObject, type: L.Type),
                                callback: (typedListener: L) ->()) {
        if let listenerTyped = listener as? L {
            callback(typedListener: listenerTyped)
        } else {
            assert(false, "Types incorrect")
        }
    }
    
    static func typeConfirmation<L,A>(listener listener: (object: AnyObject, type: L.Type),
                                arg1: (object: AnyObject, type: A.Type),
                                callback: (typedListener: L, typedArg1: A) ->()) {
        if let listenerTyped = listener.object as? L,
            let arg1Typed = arg1.object as? A {
            callback(typedListener: listenerTyped, typedArg1: arg1Typed)
        } else {
            assert(false, "Types incorrect")
        }
    }
    
    static func typeConfirmation<L,A,B>(listener listener: (object: AnyObject, type: L.Type),
                                arg1: (object: AnyObject, type: A.Type),
                                arg2: (object: AnyObject, type: B.Type),
                                callback: (typedListener: L, typedArg1: A, typedArg2: B) ->()) {
        if let listenerTyped = listener as? L,
            let arg1Typed = arg1.object as? A,
            let arg2Typed = arg2.object as? B {
            callback(typedListener: listenerTyped, typedArg1: arg1Typed, typedArg2: arg2Typed)
        } else {
            assert(false, "Types incorrect")
        }
    }
    
    static func typeConfirmation<L,A,B,C>(listener listener: (object: AnyObject, type: L.Type),
                                arg1: (object: AnyObject, type: A.Type),
                                arg2: (object: AnyObject, type: B.Type),
                                arg3: (object: AnyObject, type: C.Type),
                                callback: (typedListener: L, typedArg1: A, typedArg2: B, typedArg3: C) ->()) {
        if let listenerTyped = listener as? L,
            let arg1Typed = arg1.object as? A,
            let arg2Typed = arg2.object as? B,
            let arg3Typed = arg3.object as? C {
            callback(typedListener: listenerTyped, typedArg1: arg1Typed, typedArg2: arg2Typed, typedArg3: arg3Typed)
        } else {
            assert(false, "Types incorrect")
        }
    }
}

// MARK: SignalObserver
class SwignalObserver: Equatable {
    let swignal: Swignal!
    weak var observer: AnyObject?
    
    init(swignal: Swignal, observer: AnyObject) {
        self.swignal = swignal
        self.observer = observer
    }
    
    func handleFire(args:[AnyObject]) {
        assert(false, "This method must be overriden by the subclass")
    }
}

func ==(lhs: SwignalObserver, rhs: SwignalObserver) -> Bool {
    return lhs === rhs
}



// MARK: Helpers
private func synced(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

private extension Array {
    mutating func removeObject<T where T : Equatable>(obj: T) {
        self = self.filter({$0 as? T != obj})
    }
    
}