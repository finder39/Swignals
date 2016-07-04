//
//  Swignal0Args.swift
//  Plug
//
//  Created by Joseph Neuman on 7/3/16.
//  Copyright © 2016 Plug. All rights reserved.
//

import Foundation


typealias SwignalCallback0Args = (listener: AnyObject) -> ()


class Swignal0Args: Swignal {
    
    func fire() {
        handleFire()
    }
    
    func addObserver(observer: AnyObject, callback: SwignalCallback0Args) {
        let swignalObserver = SwignalObserver0Arg(swignal: self, observer: observer, callback: callback)
        addSwignalObserver(swignalObserver)
    }
}

class SwignalObserver0Arg: SwignalObserver {
    let callback: SwignalCallback0Args
    
    init(swignal: Swignal, observer: AnyObject, callback: SwignalCallback0Args) {
        self.callback = callback
        super.init(swignal: swignal, observer: observer)
    }
    
    override func handleFire(args:[AnyObject]) {
        if let observer = observer {
            if args.count == 0 {
                callback(listener: observer)
            }
        }
    }
}