//
//  ViewController.swift
//  boba
//
//  Created by Kenneth Zhang on 2/9/24.
//

import UIKit
import MessageUI
import MapKit
import CoreLocation

class ViewController: UIViewController, MFMailComposeViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var message: UITextField!
    
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    
    
    @IBAction func composeEmailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            if(name.text == nil || email.text == nil || subject.text == nil || message.text == nil){
                let alertController = UIAlertController(title: "Error", message: "Please make sure all inputs are filled", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            else{
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setToRecipients(["kzhang29@depaul.edu"])
                mailComposer.setSubject(subject.text!)
                mailComposer.setMessageBody(email.text! + "\n" + message.text!, isHTML: false)
                present(mailComposer, animated: true, completion: nil)
            }
        } else {
            // Show an alert if the user's device is not configured to send emails
            let alertController = UIAlertController(title: "Error", message: "Your device is not configured to send emails.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emailSender(_ sender: UIButton) {
        if (sender == clear) {
            name.text = nil
            email.text = nil
            subject.text = nil
            message.text = nil
        }
    }
    
    @IBAction func doneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func didTapBackground(_ sender: UIControl){
        sender.resignFirstResponder()
    }
    
}

