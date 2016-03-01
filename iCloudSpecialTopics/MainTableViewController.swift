//
//  MainTableViewController.swift
//  iCloudSpecialTopics
//
//  Created by Victor Hawley on 2/29/16.
//  Copyright © 2016 Victor Hawley Jr. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var groceries: [Grocery] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let moContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Grocery")
        
        do {
            groceries = try moContext.executeFetchRequest(fetchRequest) as! [Grocery]
        } catch {
            print("Error: \(error)")
        }
        
        // Test code: add entity
        /*let entity = NSEntityDescription.entityForName("Grocery", inManagedObjectContext: moContext)
        let testObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moContext) as! Grocery
        
        testObject.name = "Milk"
        testObject.price = 4.99
        testObject.purchased = false
        testObject.quantity = 4
        
        groceries.append(testObject)
        
        do {
            try moContext.save()
        } catch {
            print("Error: \(error)")
        } */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groceries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groceryCell", forIndexPath: indexPath)
        
        let g = groceries[indexPath.row]
        
        if let groceryCell = cell as? GroceryTableViewCell {
            groceryCell.nameLabel.text = g.name
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            groceryCell.priceLabel.text = formatter.stringFromNumber(g.price!)
            
            if let q = g.quantity {
                groceryCell.quantityLabel.text = "Need: \(q)"
            } else {
                groceryCell.quantityLabel.text = ""
            }
        }

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
