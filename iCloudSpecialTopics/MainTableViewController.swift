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
    
    func storesDidChange() {
        print("NSPersistentStoreCoordinatorStoresDidChangeNotification")
        let moContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Grocery")
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            groceries = try moContext.executeFetchRequest(fetchRequest) as! [Grocery]
        } catch {
            print("Error: \(error)")
        }
    }
    
    func storesWillChange() {
        print("NSPersistentStoreCoordinatorStoresWillChangeNotification")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let moContext = appDelegate.managedObjectContext
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "storesDidChange", name: NSPersistentStoreCoordinatorStoresDidChangeNotification, object: moContext.persistentStoreCoordinator)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "storesWillChange", name: NSPersistentStoreCoordinatorStoresWillChangeNotification, object: moContext.persistentStoreCoordinator)
        
        let fetchRequest = NSFetchRequest(entityName: "Grocery")
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            groceries = try moContext.executeFetchRequest(fetchRequest) as! [Grocery]
        } catch {
            print("Error: \(error)")
        }
        
        // Test code: add entity
        let entity = NSEntityDescription.entityForName("Grocery", inManagedObjectContext: moContext)
        let testObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: moContext) as! Grocery
        
        testObject.name = "Milk"
        testObject.price = 4.99
        testObject.purchased = false
        testObject.quantity = NSNumber(unsignedInt: arc4random() % 10)
        testObject.index = groceries.count 
        
        groceries.append(testObject)
        
        do {
            try moContext.save()
        } catch {
            print("Error: \(error)")
        }
        
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
                if let i = g.index {
                    groceryCell.quantityLabel.text = "Need: \(q) Index: \(i)"
                }
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
            let moContext = appDelegate.managedObjectContext
            
            
            do {
                moContext.deleteObject(groceries[indexPath.row]) //delete from core data
                groceries.removeAtIndex(indexPath.row) //delete from memory
                for (var i = indexPath.row; i < groceries.count; i++) { //update indices of elements after deleted object
                    groceries[i].index = i
                }
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

                try moContext.save()
            } catch {
                print("Error: \(error)")
            }
            tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let moContext = appDelegate.managedObjectContext
        
        let g = groceries[fromIndexPath.row]
        groceries.removeAtIndex(fromIndexPath.row)
        groceries.insert(g, atIndex: toIndexPath.row)
        
        for (var i = min(fromIndexPath.row, toIndexPath.row); i <= max(fromIndexPath.row, toIndexPath.row); i++ ) {
            groceries[i].index = i
        }
        
        do {
            try moContext.save()
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
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
