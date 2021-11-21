//
//  DateViewController.swift
//  CountDown Timer
//
//  Created by Ali Hameedaldeen on 07/11/2021.
//

import UIKit

class DateViewController: UIViewController {

    
    @IBOutlet weak var EventNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    var nameOfEvent: String?
    var dateOfEvent: Date?
    
    var countDownLogic = CountDownLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    updateLabels()
        
    }
    
    func updateLabels() {
        countDownLogic.eventCreated(name: nameOfEvent!, date: dateOfEvent!)
        
        self.DateLabel.text = self.countDownLogic.Eventdate

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            self.DateLabel.text = self.countDownLogic.Eventdate
        }

        EventNameLabel.text = countDownLogic.Eventname
    }

}

