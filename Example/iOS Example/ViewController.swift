//
//  ViewController.swift
//  iOS Example
//
//  Created by Joseph Neuman on 7/6/16.
//  Copyright © 2016 Swignals. All rights reserved.
//

import UIKit

typealias OnColorChangedSwignal = Swignal1Arg<UIColor>
typealias OnCountChangedSwignal = Swignal2Args<Int, UIButton>

class ViewController: UIViewController {

    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var minusOne: UIButton!
    @IBOutlet weak var plusOne: UIButton!
    @IBOutlet weak var countOne: UILabel!
    @IBOutlet weak var countTwo: UILabel!
    @IBOutlet weak var countThree: UILabel!
    
    var count = 0
    
    let onColorChangedSwignal = OnColorChangedSwignal()
    let onCountChangedSwignal = OnCountChangedSwignal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onColorChangedSwignal.addObserver(self) { (weakSelf, color) in
            weakSelf.view.backgroundColor = color
        }
        
        onCountChangedSwignal.addObserver(countOne) { (weakButton, count, button) in
            weakButton.text = "\(count)"
            if button === self.minusOne {
                weakButton.textColor = UIColor.redColor()
            } else if button === self.plusOne {
                weakButton.textColor = UIColor.greenColor()
            }
        }
        
        onCountChangedSwignal.addObserver(countTwo) { (weakButton, count, button) in
            weakButton.text = "\(count)"
            if button === self.minusOne {
                weakButton.textColor = UIColor.redColor()
            } else if button === self.plusOne {
                weakButton.textColor = UIColor.greenColor()
            }
        }
        
        onCountChangedSwignal.addObserver(countThree) { (weakButton, count, button) in
            weakButton.text = "\(count)"
            if button === self.minusOne {
                weakButton.textColor = UIColor.redColor()
            } else if button === self.plusOne {
                weakButton.textColor = UIColor.greenColor()
            }
        }
    }

    @IBAction func colorButtonTapped(sender: UIButton) {
        switch sender {
        case redButton:
            onColorChangedSwignal.fire(UIColor.redColor())
        case blueButton:
            onColorChangedSwignal.fire(UIColor.blueColor())
        case greenButton:
            onColorChangedSwignal.fire(UIColor.greenColor())
        default:
            break
        }
    }
    
    @IBAction func countAdjusterPressed(sender: UIButton) {
        switch sender {
        case minusOne:
            count -= 1
        case plusOne:
            count += 1
        default:
            break
        }
        onCountChangedSwignal.fire(count, arg2: sender)
    }
    

}

