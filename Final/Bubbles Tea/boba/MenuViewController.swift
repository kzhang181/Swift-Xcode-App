//
//  MenuViewController.swift
//  boba
//
//  Created by Kenneth Zhang on 2/26/24.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        mt.value = Double(data.shared.cartItemNumber[0])
        mtCount.text = String(data.shared.cartItemNumber[0])
        ft.value = Double(data.shared.cartItemNumber[1])
        ftCount.text = String(data.shared.cartItemNumber[1])
        smoothie.value = Double(data.shared.cartItemNumber[2])
        smoothieCount.text = String(data.shared.cartItemNumber[2])
        matcha.value = Double(data.shared.cartItemNumber[3])
        matchaCount.text = String(data.shared.cartItemNumber[3])
    }
    
    @IBOutlet weak var mt: UIStepper!
    @IBOutlet weak var mtCount: UILabel!
    @IBOutlet weak var matcha: UIStepper!
    @IBOutlet weak var matchaCount: UILabel!
    @IBOutlet weak var smoothie: UIStepper!
    @IBOutlet weak var smoothieCount: UILabel!
    @IBOutlet weak var ft: UIStepper!
    @IBOutlet weak var ftCount: UILabel!
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func addMT(_ sender: UIStepper) {
        mtCount.text = String(Int(sender.value))
        data.shared.cartItemNumber[0] = Int(sender.value)
    }
    @IBAction func addFT(_ sender: UIStepper) {
        ftCount.text = String(Int(sender.value))
        data.shared.cartItemNumber[1] = Int(sender.value)
    }
    @IBAction func addSmoothie(_ sender: UIStepper) {
        smoothieCount.text = String(Int(sender.value))
        data.shared.cartItemNumber[2] = Int(sender.value)
    }
    @IBAction func addMatcha(_ sender: UIStepper) {
        matchaCount.text = String(Int(sender.value))
        data.shared.cartItemNumber[3] = Int(sender.value)
    }
    
    @IBAction func addItems(_ sender: UIButton) {
        data.shared.addOrder = true
    }
}
