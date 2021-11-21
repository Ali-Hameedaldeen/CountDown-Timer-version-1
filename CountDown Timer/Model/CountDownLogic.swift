//
//  CountDown Logic.swift
//  CountDown Timer
//
//  Created by Ali Hameedaldeen on 07/11/2021.
//

import UIKit
import AVFoundation


class CountDownLogic {
    
    var Eventname: String?
    var Eventdate: String?
        
    let settings = SettingsViewController()
    
    var player = AVAudioPlayer()
    
    var days: Int = 0
    var hours: Int = 0
    var mins: Int = 0
    var secs: Int = 0
    
    
    func eventCreated(name: String, date: Date) {
        
        Eventname = name
        
        let difference = floor(date.timeIntervalSince(Date()))
            
            let totalDays: Int = Int(difference) / 86400
            let remainder1: Int = Int(difference) - (totalDays * 86400)
            let totalHours: Int = Int(remainder1) / 3600
            let remainder2: Int = Int(difference) - (totalDays * 86400) - (totalHours * 3600)
            let minutes: Int = Int(remainder2) / 60
            let seconds: Int = Int(difference) - (totalDays * 86400) - (totalHours * 3600) - (minutes * 60)
            
            days = totalDays
            hours = totalHours
            mins = minutes
            secs = seconds
                        
            updateLabel()
            
            startTimer ()
        
    }
    
    func startTimer() {
        
        let sound = self.settings.userDefaults.bool(forKey: "soundEnabled")
        let vibration = self.settings.userDefaults.bool(forKey: "vibrationEnabled")
        
        if self.hours > 0 || self.mins > 0 || self.secs > 0 {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                
                
                if self.secs > 0 {
                    self.secs = self.secs - 1
                } else if self.mins > 0 && self.secs == 0 {
                    self.mins = self.mins - 1
                    self.secs = 59
                } else if self.hours > 0 && self.mins == 0 && self.secs == 0 {
                    self.hours = self.hours - 1
                    self.mins = 59
                    self.secs = 59
                } else if self.days > 0 && self.hours == 0 && self.mins == 0 && self.secs == 0 {
                    self.days = self.days - 1
                    self.hours = 23
                    self.mins = 59
                    self.secs = 59
                }
                self.updateLabel()
            }
        } else {

                self.days = 0
                self.hours = 0
                self.mins = 0
                self.secs = 0
            
                if sound && vibration {
                    DispatchQueue.main.async {
        
                            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "alarm", ofType: "mp3")!)
                            try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                            try! AVAudioSession.sharedInstance().setActive(true)
                            self.player = try! AVAudioPlayer(contentsOf: alertSound)
                            self.player.play()
                            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        
                    }

                    print("Nothing Disabled")

                } else if sound == true && vibration == false {
                    
                    DispatchQueue.main.async {
                    
                            let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "alarm", ofType: "mp3")!)
                            try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                            try! AVAudioSession.sharedInstance().setActive(true)
                            self.player = try! AVAudioPlayer(contentsOf: alertSound)
                            self.player.play()
                    
                        }
                        

                    print("Vibration Disabled")

                } else if sound == false && vibration == true {
                    
                    DispatchQueue.main.async {
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    }
                    print("Sound Disabled")

                } else {
                    print("All Disabled")
                }

            self.updateLabel()

        }
//            else {
//            self.days = 0
//            self.hours = 0
//            self.mins = 0
//            self.secs = 0
//
//            self.updateLabel()
//        }
    }
    
    func updateLabel() {
        
        let dayCount = days == 1 ? "day" : "days"
    
        Eventdate = ("""
        \(days) \(dayCount)
        
        \(hours):\(mins):\(secs)
        """)
    }
}

