//
//  ViewController.swift
//  Tipsy
//
//  Created by Work on 9/3/15.
//  Copyright (c) 2015 Kevin Kirkhoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var percent5: UILabel!
    @IBOutlet weak var percent10: UILabel!
    @IBOutlet weak var percent15: UILabel!
    @IBOutlet weak var percent20: UILabel!
    
    @IBOutlet weak var total5: UILabel!
    @IBOutlet weak var total10: UILabel!
    @IBOutlet weak var total15: UILabel!
    @IBOutlet weak var total20: UILabel!
    
    @IBOutlet weak var subtotalTextField: UITextField!
    @IBOutlet weak var roundUpSwitch: UISwitch!
    
    var subtotal: Float = 0.0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    // Make sure users can still see the Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    // Triggered when tapping the RoundUp switch
    @IBAction func roundUpSwitch(sender: UISwitch)
    {
        computeTotals()
    }
    
    // Called when the user taps on the screen
    // This makes the keypad disappear
    @IBAction func viewTapped(sender: UITapGestureRecognizer)
    {
        subtotalTextField.resignFirstResponder()
    }
    
    // When the user taps a number. It takes that number and computes the tips and totals.
    @IBAction func enteredNumber(sender: UITextField)
    {
        
        subtotal = Float((sender.text as NSString).doubleValue)     // Convert text box amount to a Float
        
        computeTotals()
    }
    
    // Compute the tips and totals.
    // *** This should be a class method, with a class for a tip and one for a total. ***
    func computeTotals()
    {
        // Compute the tip amounts
        var tip5 = subtotal * 0.05
        var tip10 = subtotal * 0.10
        var tip15 = subtotal * 0.15
        var tip20 = subtotal * 0.20
        
        if (roundUpSwitch.on)
        {
            var roundup: Float
            var temp: Float
            var remainder: Float
            
            // Example (subtotal of 27.03. Tip 1.35)
            temp = trunc(tip5 + subtotal)                   // Truncate the subtotal (28.38 becomes 28.00)
            remainder = tip5 + subtotal - temp              // Determine amount to add (28.38 - 28.00)
            tip5 = roundUp(tip5, remainder: remainder)      // tip5 becomes .62, making the total 29.00
            
            temp = trunc(tip10 + subtotal)
            remainder = tip10 + subtotal - temp
            tip10 = roundUp(tip10, remainder: remainder)
            
            temp = trunc(tip15 + subtotal)
            remainder = tip15 + subtotal - temp
            tip15 = roundUp(tip15, remainder: remainder)
            
            temp = trunc(tip20 + subtotal)
            remainder = tip20 + subtotal - temp
            tip20 = roundUp(tip20, remainder: remainder)
            
        }
        else
        {

        }
        
        // Convert tip amounts to strings for displaying
        percent5.text = String(format: "$%0.2f", tip5)
        percent10.text = String(format: "$%0.2f", tip10)
        percent15.text = String(format: "$%0.2f", tip15)
        percent20.text = String(format: "$%0.2f", tip20)
        
        // Add tips to user-entered subtotals and convert to strings for displaying.
        total5.text = String(format: "$%0.2f", subtotal + tip5)
        total10.text = String(format: "$%0.2f", subtotal + tip10)
        total15.text = String(format: "$%0.2f", subtotal + tip15)
        total20.text = String(format: "$%0.2f", subtotal + tip20)
        
    }
    
    // This will determine the amount needed to round the total up to a whole number (ie no cents)
    func roundUp(initialTip: Float, remainder: Float)->(Float)
    {
        var roundup: Float = 0
        var tip: Float = 0
        
        // Only compute when there is a remaninder. Otherwise, if cents is .00 roundup will be 1
        if (remainder > 0)
        {
            // Subtract the old tip amount (cents) from 1.
            roundup = 1 - remainder
        }
        else
        {
            // Subtotal is already whole number (no cents)
            roundup = 0
        }
        
        // Add the rounded up amount to the initial tip
        tip = initialTip + roundup
        
        return (tip)
    }
    
}

