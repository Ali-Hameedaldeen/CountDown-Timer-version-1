//
//  SettingsViewController.swift
//  CountDown Timer
//
//  Created by Ali Hameedaldeen on 08/11/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var vibrationLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibrationSwitch: UISwitch!
    
    var soundEnabled = true
    var vibrationEnabled = true
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        soundLabel.text = "Sound Enabled"
        soundLabel.textColor = .white

        vibrationLabel.text = "Vibration Enabled"
        vibrationLabel.textColor = .white
        
        userPreferences()
        
    }
    
    

    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if soundEnabled {
          
            soundEnabled = false
            soundLabel.text = "Sound Disabled"


        } else {
            soundEnabled = true
            soundLabel.text = "Sound Enabled"

        }
        userDefaults.set(soundEnabled, forKey: "soundEnabled")
    }
    
    @IBAction func vibrationSwtichPressed(_ sender: UISwitch) {
        
        if vibrationEnabled {
            vibrationEnabled = false
            vibrationLabel.text = "Vibration Disabled"
        
        } else {
            vibrationEnabled = true
            vibrationLabel.text = "Vibration Enabled"
           
        }
        userDefaults.set(vibrationEnabled, forKey: "vibrationEnabled")
        
    }
    
    
    func userPreferences() {

        soundEnabled = userDefaults.bool(forKey: "soundEnabled")
        soundSwitch.isOn = soundEnabled
        if soundSwitch.isOn {
        soundLabel.text = "Sound Enabled"
        } else {
        soundLabel.text = "Sound Disabled"
        }
        
        vibrationEnabled = userDefaults.bool(forKey: "vibrationEnabled")
        vibrationSwitch.isOn = vibrationEnabled
        if vibrationSwitch.isOn {
        vibrationLabel.text = "Vibration Enabled"
        } else {
        vibrationLabel.text = "Vibration Disabled"
        }
    }
}
