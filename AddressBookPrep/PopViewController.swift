//
//  PopViewController.swift
//  AddressBookPrep
//
//  Created by Jon Eikholm on 12/10/2018.
//  Copyright © 2018 Jon Eikholm. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var parentVC:TableViewController1?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onGoPressed(_ sender: Any) {
        print(34)
                if let t = textField.text {
                    parentVC?.addToFirebase(name: t)
                }
        parentVC?.dismiss(animated: true, completion: nil)
    }
    
}
