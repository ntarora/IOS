//
//  CarViewController.swift
//  iCarSales
//
//  Created by Neel A on 12/9/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class CarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var scrollView: UIScrollView!
    var carToPass = NSArray()
    var vinPass = ""
    var make1 = ""
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var listOfMakes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listOfMakes = applicationDelegate.make_dict_cars.allKeys as! [String]
        listOfMakes.sortInPlace{$0 < $1}
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "toCarDetail")
        {
            let dvc = segue.destinationViewController as! CarDetailViewController
            dvc.passedCar = carToPass;
            dvc.vin = vinPass
            dvc.make = make1
        }
    }

    
    // MARK: - Tableview datasource delgate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("carCell", forIndexPath: indexPath) as! CarTableViewCell
        
        let make = listOfMakes[indexPath.section];
        let carDict = applicationDelegate.make_dict_cars[make] as! NSDictionary
        let vinKeys = carDict.allKeys as! [String]
        let car = carDict[vinKeys[indexPath.row]] as! NSArray
        
        cell.carTrimLabel.text = (car[0] as! String) + " " + "\(car[1]) " +  "\(car[2])"
        cell.priceLael.text = "\(car[4])"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let make = listOfMakes[section]
        let carDict = applicationDelegate.make_dict_cars[make] as! NSDictionary
        
        return carDict.allKeys.count
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listOfMakes[section]
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return listOfMakes.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let make = listOfMakes[indexPath.section];
        let carDict = applicationDelegate.make_dict_cars[make] as! NSDictionary
        let vinKeys = carDict.allKeys as! [String]
        let car = carDict[vinKeys[indexPath.row]] as! NSArray
        
        carToPass = car;
        vinPass = vinKeys[indexPath.row]
        make1 = make
        performSegueWithIdentifier("toCarDetail", sender: self)
    }
    
    
    //-------------------------------
    // Allow Editing of Rows
    //-------------------------------
    
    // We allow each row of the table view to be editable, i.e., deletable or movable
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    // This is the method invoked when the user taps the Delete button in the Edit mode
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {   // Handle the Delete action
            
            // Obtain the name of the country of the city to be deleted
            let makeKey = listOfMakes[indexPath.section]
            
            // Obtain the list of cities in the country as AnyObject
            let cars = applicationDelegate.make_dict_cars[makeKey] as! NSMutableDictionary
            let vins = cars.allKeys as! [String]
            // Typecast the AnyObject to Swift array of String objects
            cars.removeObjectForKey(vins[indexPath.row])
            if cars.count == 0 {
                // If no city remains in the array after deletion, then we need to also delete the country
                applicationDelegate.make_dict_cars.removeObjectForKey(makeKey)
                
                // Since the dictionary has been changed, obtain the country names again
                listOfMakes = applicationDelegate.make_dict_cars.allKeys as! [String]
                
                // Sort the country names within itself in alphabetical order
                listOfMakes.sortInPlace { $0 < $1 }
            }
            else {
                // At least one more city remains in the array; therefore, the country stays.
                
                // Update the new list of cities for the country in the NSMutableDictionary
                applicationDelegate.make_dict_cars.setValue(cars, forKey: makeKey)
            }
            
            // Reload the rows and sections of the Table View countryCityTableView
            tableView.reloadData()
        }
    }
    
    
    
    /*
    ----------------------------------------------
    MARK: - Unwind Segue Method
    ----------------------------------------------
    */
    @IBAction func unwindToCarTableViewController (segue : UIStoryboardSegue) {
     if(segue.identifier == "addCar-Save")
     {
        let svc = segue.sourceViewController as! AddCarViewController
        // Obtain the object reference of the source view controller
        let alertController = UIAlertController(title: "OOPS", message: "Fill all text fields, and hit tag location",
            preferredStyle: UIAlertControllerStyle.Alert)
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        if(svc.makeTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.modelTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.yearTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.trimTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.priceTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.mileageTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.notesTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.vinTextField.text == "")
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(svc.long == 0 || svc.lat == 0)
        {
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if(listOfMakes.contains(svc.makeTextField.text!))
        {
            let array = NSMutableArray(objects: svc.yearTextField.text!, svc.modelTextField.text!, svc.trimTextField.text!, "", svc.priceTextField.text!, svc.mileageTextField.text!, svc.long, svc.lat, svc.notesTextField.text!)
            let dict = applicationDelegate.make_dict_cars[svc.makeTextField.text!] as! NSMutableDictionary
            dict.setValue(array, forKey: svc.vinTextField.text!)
            applicationDelegate.make_dict_cars.setValue(dict, forKey: svc.makeTextField.text!)
            
            tableView.reloadData()
            
            
        }
        else
        {
            let array = NSMutableArray(objects: svc.yearTextField.text!, svc.modelTextField.text!, svc.trimTextField.text!, "", svc.priceTextField.text!, svc.mileageTextField.text!, svc.long, svc.lat, svc.notesTextField.text!)
            let dict = applicationDelegate.make_dict_cars[svc.makeTextField.text!] as! NSMutableDictionary
            dict.setValue(array, forKey: svc.vinTextField.text!)
            applicationDelegate.make_dict_cars.setValue(dict, forKey: svc.makeTextField.text!)
            
            listOfMakes = applicationDelegate.make_dict_cars.allKeys as! [String]
            listOfMakes.sortInPlace{$0 < $1}
            tableView.reloadData()
        }
        
        
        }
    }
    
    @IBAction func addPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("addCar", sender: self)
    }

    @IBAction func editPressed(sender: UIBarButtonItem) {
        if(tableView.editing == true)
        {
            tableView.setEditing(false, animated: true)
        }
        else
        {
            tableView.setEditing(true, animated: true)
        }
    }
}
