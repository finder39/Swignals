//
//  Swignal2Args.swift
//  Plug
//
//  Created by Joseph Neuman on 7/3/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation


typealias SwignalCallback2Args = (listener: AnyObject, arg1: AnyObject, arg2: AnyObject) -> ()


class Swignal2Args: Swignal {
    
    func fire(arg1: AnyObject, arg2: AnyObject) {
        handleFire(arg1, arg2)
    }
    
    func addObserver(observer: AnyObject, callback: SwignalCallback2Args) {
        let swignalObserver = SwignalObserver2Args(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(swignalObserver)
    }
}

class SwignalObserver2Args: SwignalObserver {
    let callback: SwignalCallback2Args
    
    init(swignal: Swignal, observer: AnyObject, callback: SwignalCallback2Args) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func handleFire(args:[AnyObject]) {
        if let observer = observer {
            if args.count == 2 {
                callback(listener: observer, arg1: args[0], arg2: args[1])
            }
        }
    }
}