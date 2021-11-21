//
//  AddEventViewController.swift
//  CountDown Timer
//
//  Created by Ali Hameedaldeen on 07/11/2021.
//

import UIKit

class AddEventViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var EventField: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        EventField.becomeFirstResponder()
        EventField.delegate = self
        EventField.attributedPlaceholder = NSAttributedString(
            string: "Enter Event Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.3)]
        )
        
        EventField.resignFirstResponder()
    }
    
    @IBAction func SavePressed(_ sender: UIButton) {
        
        if DatePicker.date.timeIntervalSince(Date()) > 0 {
            performSegue(withIdentifier: "SaveEvent", sender: self)
        } else {
            let alert = UIAlertController(title: "Oops!", message: "Invalid date. Please Enter a valid date.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! EventsVC
        
        let name = (EventField.text != "") ? EventField.text : "No Event Name"
        
        
        vc.eventName = name
        
        
        vc.eventDate = DatePicker.date
        
    }
    
}
