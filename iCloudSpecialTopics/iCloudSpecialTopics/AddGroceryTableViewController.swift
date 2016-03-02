//
//  AddGroceryTableViewController.swift
//  iCloudSpecialTopics
//
//  Created by Victor Hawley on 3/1/16.
//  Copyright © 2016 Victor Hawley Jr. All rights reserved.
//

import UIKit
import CoreData

class AddGroceryTableViewController: UITableViewController {

    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var quantityTextView: UITextView!
    @IBOutlet weak var purchasedSwitch: UISwitch!
    
    var originVC: UIViewController?
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func cancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        let moContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Grocery", inManagedObjectContext: moContext)
        if let g = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moContext) as? Grocery {
            if let mainVC = originVC as? MainTableViewController {
                g.index = mainVC.groceries.count
                g.name = nameTextView.text
                g.price = Double(priceTextView.text)
                g.quantity = Int(quantityTextView.text)
                g.purchased = purchasedSwitch.on
                mainVC.groceries.append(g)
                
                do {
                    try moContext.save()
                } catch {
                    print("Error: \(error)")
                }

            }
            

        }
        dismissViewControllerAnimated(true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print(segue.identifier)
    }

}
