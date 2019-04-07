//
//  DetailViewController.swift
//  milestone 1
//
//  Created by Min young Go on 4/4/19.
//  Copyright © 2019 Min young Go. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {
    
    
    
    var detailObject = [Location]()
    let backupObject = [Location]()
    var index = 2
   
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var longTextField: UITextField!
    @IBOutlet weak var latTextField: UITextField!
    
    /// Updating the each cell
    ///
    /// - Parameter sender: UIButton
    @IBAction func update(_ sender: UIButton) {
        guard let di = detailItem, let name = nameTextField.text else{return}
        di.name = name
        detailObject[index].name = name
        guard let diAddress = detailItem, let address = addressTextField.text else{return}
        diAddress.address = address
        detailObject[index].address = address
        guard let diLong = detailItem, let long = longTextField.text else{return}
        diLong.long = Double(long)!
        detailObject[index].long = Double(long)!
        guard  let diLat = detailItem, let lat = latTextField.text else {return}
        diLat.lat = Double(lat)!
        detailObject[index].lat = Double(lat)!
    

        performSegue(withIdentifier: "updateWay", sender: self)
        
    }
    
    /// take detail objects to master view
    ///
    /// - Parameters:
    ///   - segue: UIstoryboardSegue
    ///   - sender: Any
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let masterVC = (segue.destination) as! MasterViewController
        masterVC.objects = detailObject
    }
    
    
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let name = nameTextField {
                name.text = detail.name
            }
            if let address = addressTextField {
                address.text = detail.address
            }
            if let long = longTextField {
                long.text = "\(detail.long)"
            }
            if let lat = latTextField {
                lat.text = "\(detail.lat)"
            }
        }
    }
    @objc
    func cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        addressTextField.delegate = self
        longTextField.delegate = self
        latTextField.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)) )
        navigationItem.rightBarButtonItem = cancelButton
   
    
        
    }
    

    

    var detailItem: Location? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
