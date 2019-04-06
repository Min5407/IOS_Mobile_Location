//
//  AddViewController.swift
//  milestone 1
//
//  Created by Min young Go on 4/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import UIKit
import CoreLocation


class AddViewController: UIViewController {
    
    
    var addObjects = [Location]()
    let count = 0

    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        
        addObjects.append(Location(name: name, address: address, lat: lat, long: long))
        
        if count == saveCount{
            performSegue(withIdentifier: "saveWay", sender: self)
            saveCount += 1
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let masterVC = (segue.destination) as! MasterViewController
        masterVC.objects = addObjects
    }
    
  
    
    
   
    var activeField: UITextField?

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tap anywhere to hide the keyboard
        let tap =  UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // move the screen when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardhide(notifacation:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.delegate = self
        addressTextField.delegate = self
        longTextField.delegate = self
        latTextField.delegate = self
        
        self.activeField = UITextField()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
 
    /// function for dissmissing keyboard
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    /// keyboard will show with after pushing the contents up by calculating the height
    ///
    /// - Parameter notification: notification
    @objc func keyboardWillShow(notification: Notification){
        guard let keyboardInfo = notification.userInfo else{return}
        if let keyboardSize = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size{
            let keyboardHeight = keyboardSize.height + 10
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollView.contentInset = contentInsets
            var viewRect = self.view.frame
            viewRect.size.height -= keyboardHeight
            guard let activeField = self.activeField else {return}
            if(!viewRect.contains(activeField.frame.origin)){
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    /// keyboard will hide
    ///
    /// - Parameter notifacation: notifacation
    @objc func keyboardhide(notifacation:Notification){
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
    }
    

}

extension AddViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeField = nil
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressTextField.text!) {
            placemarks, error in
            let placemark = placemarks?.first
            guard
                let lat = placemark?.location?.coordinate.latitude,
                let lon = placemark?.location?.coordinate.longitude
                else{
                    return
            }
            
            self.longTextField.text! = "\(lon)"
            self.latTextField.text! = "\(lat)"
        }
    }
    
   
}


