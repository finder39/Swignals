//
//  Swignal3Args.swift
//  Plug
//
//  Created by Joseph Neuman on 7/3/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation

public class Swignal3Args<A,B,C>: SwignalBase {
    
    func addObserver<L: AnyObject>(observer: L, callback: (observer: L, arg1: A, arg2: B, arg3: C) -> ()) {
        let observer = Observer3Args(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(observer)
    }
    
    func fire(arg1: A, arg2: B, arg3: C) {
        synced(self) {
            for watcher in self.swignalObservers {
                watcher.fire(arg1, arg2, arg3)
            }
        }
    }
}

private class Observer3Args<L: AnyObject,A,B,C>: ObserverGenericBase<L> {
    let callback: (observer: L, arg1: A, arg2: B, arg3: C) -> ()
    
    init(swignal: SwignalBase, observer: L, callback: (observer: L, arg1: A, arg2: B, arg3: C) -> ()) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func fire(args: Any...) {
        if let arg1 = args[0] as? A,
            let arg2 = args[1] as? B,
            let arg3 = args[2] as? C {
            fire(arg1: arg1, arg2: arg2, arg3: arg3)
        } else {
            assert(false, "Types incorrect")
        }
    }
    
    private func fire(arg1 arg1: A, arg2: B, arg3: C) {
        if let observer = observer {
            callback(observer: observer, arg1: arg1, arg2: arg2, arg3: arg3)
        }
    }
}