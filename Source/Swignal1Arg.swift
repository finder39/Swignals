//
//  SwignalCallbackProtocols.swift
//  Plug
//
//  Created by Joseph Neuman on 7/2/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation

public class Swignal1Arg<A>: SwignalBase {
    
    func addObserver<L: AnyObject>(observer: L, callback: (observer: L, arg1: A) -> ()) {
        let observer = Observer1Args(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(observer)
    }
    
    func fire(arg1: A) {
        synced(self) {
            for watcher in self.swignalObservers {
                watcher.fire(arg1)
            }
        }
    }
}

private class Observer1Args<L: AnyObject,A>: ObserverGenericBase<L> {
    let callback: (observer: L, arg1: A) -> ()
    
    init(swignal: SwignalBase, observer: L, callback: (observer: L, arg1: A) -> ()) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func fire(args: Any...) {
        if let arg1 = args[0] as? A {
            fire(arg1: arg1)
        } else {
            assert(false, "Types incorrect")
        }
    }
    
    private func fire(arg1 arg1: A) {
        if let observer = observer {
            callback(observer: observer, arg1: arg1)
        }
    }
}