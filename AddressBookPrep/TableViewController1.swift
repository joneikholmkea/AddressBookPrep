//
//  TableViewController1.swift
//  AddressBookPrep
//
//  Created by Jon Eikholm on 12/10/2018.
//  Copyright © 2018 Jon Eikholm. All rights reserved.
//

import UIKit
import Firebase

class Global {
    var ref:DatabaseReference?
}
let global = Global()
class TableViewController1: UITableViewController, UIPopoverPresentationControllerDelegate {

    var people = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        global.ref = Database.database().reference()
        print(global.ref.debugDescription)
        queryDatabase()
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            cell.textLabel?.text = people[indexPath.row]
        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(47)
    }
    
    func queryDatabase() {
        global.ref?.queryOrdered(byChild: "name").observe(.value) { (snapshot) in
            self.people = [String]()
            //  print("received data \(snapshot.description)")
            for child in snapshot.children {
                let data = child as! DataSnapshot
                let dict = data.value as! [String:String] // kræver at værdi i Firebase er gemt som
                // key:value pairs
                print("received \(dict)")
                
                self.people.append(dict["name"]!)
            }
            self.tableView.reloadData()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popsegue" {
            
            let popVC = segue.destination as! PopViewController
            popVC.preferredContentSize = CGSize(width: 250, height: 150)
            popVC.parentVC = self
            
            let popPresentCtrl = popVC.popoverPresentationController
            //popPresentCtrl?.sourceView = showBtn // not needed
            //  popPresentCtrl?.sourceRect = CGRect(x: 0, y: -100, width: 200, height: 200)
           // popPresentCtrl?.permittedArrowDirections = UIPopoverArrowDirection.up
            popPresentCtrl?.delegate = self
            print(144)
            
        }
    }
 
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        print("adaptive called")
        return UIModalPresentationStyle.none
    }

    
    @IBAction func addPerson(_ sender: Any) {
        performSegue(withIdentifier: "popsegue", sender: self)
    }
    
    func addToFirebase(name:String){
        print(127)
        let newItemRef = global.ref?.childByAutoId()
        newItemRef?.setValue(["name":name, "phone":"23452344", "address":"Solvangen 12 1.th"])
    }
    
}
