//
//  MasterViewController.swift
//  milestone 1
//
//  Created by Min young Go on 4/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

   
    var objects = [Location]()
    
 
    
    var detailViewController: DetailViewController? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
       
    }

    override func viewWillAppear(_ animated: Bool) {
      
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "addWay", sender: self)
    }
    
    

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = (segue.destination) as! DetailViewController
            detailVC.detailObject = objects
            if let indexPath = tableView.indexPathForSelectedRow {
                let index = indexPath.row
                detailVC.index = index
                let object = objects[indexPath.row]
                let controller = (segue.destination) as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.rightBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
            
        }
        
        if segue.identifier == "addWay"{
            let addVC = (segue.destination) as! AddViewController
            addVC.addObjects = objects
        }
        
      
        

    }
    
    
    /// moving the one cell in the different cell in the masterView
    ///
    /// - Parameters:
    ///   - tableView: UItableView
    ///   - sourceIndexPath: source index path
    ///   - destinationIndexPath: destination index path
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let move =  objects[sourceIndexPath.item]
        objects.remove(at: sourceIndexPath.item)
        objects.insert(move, at: destinationIndexPath.item)
        
//
        

    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = "\(object.name)"
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

