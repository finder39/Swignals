//
//  Swignal0Args.swift
//  Plug
//
//  Created by Joseph Neuman on 7/3/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation

public class Swignal0Args: SwignalBase {
    
    func addObserver<L: AnyObject>(observer: L, callback: (observer: L) -> ()) {
        let observer = Observer0Args(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(observer
        )
    }
    
    func fire() {
        synced(self) {
            for watcher in self.swignalObservers {
                watcher.fire()
            }
        }
    }
}

private class Observer0Args<L: AnyObject>: ObserverGenericBase<L> {
    let callback: (observer: L) -> ()!
    
    init(swignal: SwignalBase, observer: L, callback: (observer: L) -> ()) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func fire(args: Any...) {
        if let observer = observer {
            callback(observer: observer)
        }
    }
}