//
//  ViewController.swift
//  Gestures
//
//  Created by Mindaugas Vaiciunas on 09/11/15.
//  Copyright © 2015 Mindaugas Vaiciunas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var pinchGeasture: UIPinchGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pinchGeasture.addTarget(self, action: "pinchTriggered:")
        pinchGeasture.delegate = self
    }
    
    func pinchTriggered(gesture: UIPinchGestureRecognizer) {
        
        NSLog("Pinch trigerred")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

