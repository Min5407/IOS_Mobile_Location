//
//  AddViewController.swift
//  milestone 1
//
//  Created by Min young Go on 4/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import UIKit



class AddViewController: UIViewController {
    
    var addObjects = [Location]()
    let count = 0

    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var longTextField: UITextField!
    
    @IBOutlet weak var latTextField: UITextField!
    
    
    @IBAction func Save(_ sender: UIButton) {
        var saveCount = 0
        var name:String = ""
        var address:String = ""
        var long: Double = 0.0
        var lat: Double = 0.0
        
        if (nameTextField.text != "" && addressTextField.text != ""){
            name = nameTextField.text!
            address = addressTextField.text!
        }
        
        if (longTextField.text != "" && latTextField.text != ""){
            guard let newLong = Double(longTextField.text!) else{return}
            guard let newLat = Double(latTextField.text!) else{return}
            long = newLong
            lat = newLat
        }
        
        
        addObjects.append(Location(name: name, address: address, lat: long, long: lat))
        
        if count == saveCount{
            performSegue(withIdentifier: "saveWay", sender: self)
            saveCount += 1
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let masterVC = (segue.destination) as! MasterViewController
        masterVC.objects = addObjects
    }
    
    
   
    
  
    
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

}


