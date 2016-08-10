//
//  MyTheatersViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/17/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MyTheatersViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource{

    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var LocationTextField: UITextField!
    
    var dictnary_thet_string = NSMutableDictionary()
    var allTheater = [String]()
    
    var valueToSend : Int?
    var stringToSend : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/MyFavoriteTheaters.plist"
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInDocumentDirectory)
        if let dictionaryFromFileInDocumentDirectory = dictionaryFromFile {
            
            // CountryCities.plist exists in the Documents directory
            dictnary_thet_string = dictionaryFromFileInDocumentDirectory
            allTheater = dictnary_thet_string.allKeys as! [String]
            
        } else {
            
            // CountryCities.plist does not exist in the Documents directory; Read it from the main bundle.
            
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let plistFilePathInMainBundle = NSBundle.mainBundle().pathForResource("MyFavoriteTheaters", ofType: "plist")
            
            // Assign it to the instance variable
            let dictionary1: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInMainBundle!)
            dictnary_thet_string = dictionary1!
            allTheater = dictionary1!.allKeys as! [String]
        }
        stringToSend = (dictnary_thet_string[allTheater[0]] as! String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func segmentSelection(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            
        case 0:
            valueToSend = 0
            performSegueWithIdentifier("toMap", sender: self)
        case 1:
            valueToSend = 1
            performSegueWithIdentifier("toMap", sender: self)
        case 2:
            valueToSend = 2
            performSegueWithIdentifier("toMap", sender: self)
        case 3:
            valueToSend = 3
            performSegueWithIdentifier("toMap", sender: self)
        default:
            return
        }
        
        
    }
    
    @IBAction func segmentPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            
        case 0:
            valueToSend = 0
            performSegueWithIdentifier("toMap", sender: self)
        case 1:
            valueToSend = 1
            performSegueWithIdentifier("toMap", sender: self)
        case 2:
            valueToSend = 2
            performSegueWithIdentifier("toMap", sender: self)
        case 3:
            valueToSend = 3
            performSegueWithIdentifier("toMap", sender: self)
        default:
            return
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "toWeb")
        {
            let dvc = segue.destinationViewController as! MyTheatersWebViewController
            dvc.location = LocationTextField.text
        }
        else if(segue.identifier == "toMap")
        {
            let dvc = segue.destinationViewController as! MyTheatersMapViewController
            dvc.type = valueToSend!
            dvc.nameOfPlace = stringToSend!
        }
        
    }

    
    /*
    ----------------------------------------
    MARK: - UIPickerView Data Source Methods
    ----------------------------------------
    */
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stringToSend = (dictnary_thet_string[allTheater[row]] as! String)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return allTheater.count
    }
    
    /*
    ------------------------------------
    MARK: - UIPickerView Delegate Method
    ------------------------------------
    */
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return allTheater[row]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        performSegueWithIdentifier("toWeb", sender: self)
        
        
        return true
    }
    
    @IBAction func dismissKeyBoard(sender: UITapGestureRecognizer) {
        LocationTextField.resignFirstResponder()
    }
    @IBAction func unwindToMyTheaterViewController (segue : UIStoryboardSegue) {
        
        if(segue.identifier == "addTheater-Save")
        {
            print("save")
            let controller = segue.sourceViewController as! AddMyTheaterViewController
            let alertController = UIAlertController(title: "OOPS", message: "Fill all text fields",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            // Create a UIAlertAction object and add it to the alert controller
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            if(controller.movieTheaterAddress.text == "")
            {
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            if(controller.movieTheaterName.text == "")
            {
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //already in the dictornary
            if(allTheater.contains(controller.movieTheaterName.text!))
            {
                dictnary_thet_string.setValue(controller.movieTheaterAddress.text!, forKey: controller.movieTheaterName.text!)
                
            }
            else if(!(allTheater.contains(controller.movieTheaterName.text!)))
            {
                dictnary_thet_string.setValue(controller.movieTheaterAddress.text!, forKey: controller.movieTheaterName.text!)
            }
            
            allTheater = dictnary_thet_string.allKeys as! [String]
            
            // Define the file path to the CountryCities.plist file in the Documents directory
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDirectoryPath = paths[0] as String
            
            // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
            let plistFilePathInDocumentDirectory = documentDirectoryPath + "/MyFavoriteTheaters.plist"
            
            // Write the NSMutableDictionary to the CountryCities.plist file in the Documents directory
            dictnary_thet_string.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
            
        }
        
        if(segue.identifier == "deleteTheater")
        {
            let controller = segue.sourceViewController as! AddMyTheaterViewController
            let alertController = UIAlertController(title: "OOPS", message: "Fill all text fields",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            // Create a UIAlertAction object and add it to the alert controller
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))

            if(controller.movieTheaterName.text == "")
            {
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            //already in the dictornary
            if(allTheater.contains(controller.movieTheaterName.text!))
            {
                dictnary_thet_string.removeObjectForKey(controller.movieTheaterName.text!)
                
            }
            
            allTheater = dictnary_thet_string.allKeys as! [String]
            
            // Define the file path to the CountryCities.plist file in the Documents directory
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDirectoryPath = paths[0] as String
            
            // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
            let plistFilePathInDocumentDirectory = documentDirectoryPath + "/MyFavoriteTheaters.plist"
            
            // Write the NSMutableDictionary to the CountryCities.plist file in the Documents directory
            dictnary_thet_string.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
            
        }
        pickerView.reloadAllComponents()
    }
    
    
    

}
