//
//  ViewController.swift
//  gammacontrol
//
//  Created by Tan Thor Jen on 29/8/16.
//  Copyright © 2016 Tan Thor Jen. All rights reserved.
//

import Cocoa


class GammaSliderCell : NSSliderCell {
    override func rectOfTickMark(at index: Int) -> NSRect {
        if index == 0 || index == 9 || index == 21 {
            return super.rectOfTickMark(at: index)
        }
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
}

struct ColorGamma {
    var min: CGGammaValue = 0
    var max: CGGammaValue = 1
    var gamma: CGGammaValue = 1
}

class DisplayGamma {

    var red: ColorGamma = ColorGamma()
    var green: ColorGamma  = ColorGamma()
    var blue: ColorGamma = ColorGamma()
    
    func get() {
        let display = CGMainDisplayID()
        
        CGGetDisplayTransferByFormula(display,
                                      &red.min, &red.max, &red.gamma,
                                      &green.min, &green.max, &green.gamma,
                                      &blue.min, &blue.max, &blue.gamma)
    }
    
    func set() {
        let display = CGMainDisplayID()
        CGSetDisplayTransferByFormula(display,
                                      red.min, red.max, red.gamma,
                                      green.min, green.max, green.gamma,
                                      blue.min, blue.max, blue.gamma)
    }
}

class ViewController: NSViewController {
    
    @IBOutlet var slider: NSSlider?
    @IBOutlet var label: NSTextField?
    
    var mDisplayGamma : DisplayGamma = DisplayGamma()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGamma(self.saveGamma)
        if let sl = slider {
            sl.floatValue = self.saveGamma
        }
        refreshSliderText()
    }
    
    var saveGamma: CGGammaValue {
        get {
            if UserDefaults.standard.object(forKey: "saveGamma") == nil {
                return 1.0
            } else {
                return CGGammaValue(UserDefaults.standard.float(forKey: "saveGamma"))
            }
        }
        set {
            UserDefaults.standard.set(CGGammaValue(newValue), forKey: "saveGamma")
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func refreshSliderText() {
        if let sl = slider, let lb = label {
            let v: CGGammaValue = sl.floatValue
            let sv = String(format: "%.2f", v)
            
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let str = NSMutableAttributedString(string: "Gamma: ", attributes: [NSParagraphStyleAttributeName: style])
            let str2 =  NSAttributedString(string: sv, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: 20.0)])
            str.append(str2)
            lb.attributedStringValue = str
        }
    }
    
    func setGamma(_ gamma: CGGammaValue) {
        let setv = 1.0 / gamma
        let dg = DisplayGamma()
        dg.red.gamma = setv
        dg.blue.gamma = setv
        dg.green.gamma = setv
        dg.set()
    }
    
    @IBAction func sliderChanged(_ sender: AnyObject?) {
        if let sl = slider {
            let v: CGGammaValue = sl.floatValue
            setGamma(v)
            self.saveGamma = v
            refreshSliderText()
        }
    }


}

