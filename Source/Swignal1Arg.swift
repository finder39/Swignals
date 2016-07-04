//
//  SwignalCallbackProtocols.swift
//  Plug
//
//  Created by Joseph Neuman on 7/2/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation


typealias SwignalCallback1Arg = (listener: AnyObject, arg1: AnyObject) -> ()


class Swignal1Arg: Swignal {
    
    func fire(arg1: AnyObject) {
        handleFire(arg1)
    }
    
    func addObserver(observer: AnyObject, callback: SwignalCallback1Arg) {
        let swignalObserver = SwignalObserver1Arg(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(swignalObserver)
    }
}

class SwignalObserver1Arg: SwignalObserver {
    let callback: SwignalCallback1Arg
    
    init(swignal: Swignal, observer: AnyObject, callback: SwignalCallback1Arg) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func handleFire(args:[AnyObject]) {
        if let observer = observer {
            if args.count == 1 {
                callback(listener: observer, arg1: args[0])
            }
        }
    }
}