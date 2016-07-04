//
//  Swignal3Args.swift
//  Plug
//
//  Created by Joseph Neuman on 7/3/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation


typealias SwignalCallback3Args = (listener: AnyObject, arg1: AnyObject, arg2: AnyObject, arg3: AnyObject) -> ()


class Swignal3Args: Swignal {
    
    func fire(arg1: AnyObject, arg2: AnyObject, arg3: AnyObject) {
        handleFire(arg1, arg2, arg3)
    }
    
    func addObserver(observer: AnyObject, callback: SwignalCallback3Args) {
        let swignalObserver = SwignalObserver3Args(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(swignalObserver)
    }
}

class SwignalObserver3Args: SwignalObserver {
    let callback: SwignalCallback3Args
    
    init(swignal: Swignal, observer: AnyObject, callback: SwignalCallback3Args) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func handleFire(args:[AnyObject]) {
        if let observer = observer {
            if args.count == 3 {
                callback(listener: observer, arg1: args[0], arg2: args[1], arg3: [2])
            }
        }
    }
}