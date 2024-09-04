//
//  CartViewController.swift
//  boba
//
//  Created by Kenneth Zhang on 2/26/24.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool){
        if(data.shared.addOrder == true){
            self.totalCost = 0
            for i in 0...3{
                self.totalCost += (data.shared.cartItemNumber[i] * data.shared.itemCost[i])
            }
            data.shared.cost = self.totalCost
            self.cost.text = "$" + String(totalCost)
            self.totalItems = 0
            for i in 0...3{
                self.totalItems += data.shared.cartItemNumber[i]
            }
            self.items.text = String(totalItems)
            
            self.mtCount.text = String(data.shared.cartItemNumber[0])
            self.ftCount.text = String(data.shared.cartItemNumber[1])
            self.smoothieCount.text = String(data.shared.cartItemNumber[2])
            self.matchaCount.text = String(data.shared.cartItemNumber[3])
            
            address.text = data.shared.address
            
            data.shared.addOrder = false
        }
    } 
    
    var totalCost: Int = 0
    var totalItems: Int = 0
    @IBOutlet weak var remove1: UIButton!
    @IBOutlet weak var remove2: UIButton!
    @IBOutlet weak var remove3: UIButton!
    @IBOutlet weak var remove4: UIButton!
    
    @IBOutlet weak var mtCount: UILabel!
    @IBOutlet weak var ftCount: UILabel!
    @IBOutlet weak var smoothieCount: UILabel!
    @IBOutlet weak var matchaCount: UILabel!
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var address: UITextField!

    @IBOutlet weak var confirm: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func confirmOrder(_ sender: UIButton) {
        if sender == confirm {
            if address.text?.isEmpty ?? true{
                let alertController = UIAlertController(title: "Empty Address", message: "Please Input Address", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            else if items.text == "0"{
                let alertController = UIAlertController(title: "No Items", message: "Please Add Items to Continue", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "Order Placed!", message: "Check maps to see delivery progress", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
                data.shared.address = address.text ?? ""
            }
        }
    }
    
    @IBAction func cancelOrder(_ sender: UIButton) {
        address.text = nil;
        cost.text = "$0"
        items.text = "0"
        data.shared.cartItemNumber = [0, 0, 0, 0]
        data.shared.address = ""
        data.shared.addOrder = false
        mtCount.text = "0"
        ftCount.text = "0"
        smoothieCount.text = "0"
        matchaCount.text = "0"
    }
    
    @IBAction func removeItems(_ sender: UIButton) {
        if(sender == remove1){
            mtCount.text = "0"
            data.shared.cost -= (data.shared.cartItemNumber[0] * data.shared.itemCost[0])
            totalItems -= data.shared.cartItemNumber[0]
            items.text = String(totalItems)
            data.shared.cartItemNumber[0] = 0
            totalCost = Int(data.shared.cost)
            cost.text = "$" + String(totalCost)
        }
        if(sender == remove2){
            ftCount.text = "0"
            data.shared.cost -= (data.shared.cartItemNumber[1] * data.shared.itemCost[1])
            totalItems -= data.shared.cartItemNumber[1]
            items.text = String(totalItems)
            data.shared.cartItemNumber[1] = 0
            totalCost = Int(data.shared.cost)
            cost.text = "$" + String(totalCost)
        }
        
        if(sender == remove3){
            smoothieCount.text = "0"
            data.shared.cost -= (data.shared.cartItemNumber[2] * data.shared.itemCost[2])
            totalItems -= data.shared.cartItemNumber[2]
            items.text = String(totalItems)
            data.shared.cartItemNumber[2] = 0
            totalCost = Int(data.shared.cost)
            cost.text = "$" + String(totalCost)
        }
        if(sender == remove4){
            matchaCount.text = "0"
            data.shared.cost -= (data.shared.cartItemNumber[3] * data.shared.itemCost[3])
            totalItems -= data.shared.cartItemNumber[3]
            items.text = String(totalItems)
            data.shared.cartItemNumber[3] = 0
            totalCost = Int(data.shared.cost)
            cost.text = "$" + String(totalCost)
        }
    }
}
