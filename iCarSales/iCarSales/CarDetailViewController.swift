//
//  CarDetailViewController.swift
//  iCarSales
//
//  Created by Neel A on 12/9/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit
import MapKit
import MessageUI
class CarDetailViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate, MFMailComposeViewControllerDelegate{

    @IBOutlet var carImageView: UIImageView!
    @IBOutlet var carNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var trimLabel: UILabel!
    @IBOutlet var mileageLabel: UILabel!
    @IBOutlet var vinLabel: UILabel!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var scrollView: UIScrollView!
    let locationManager = CLLocationManager()
    
    
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var passedCar = NSArray()
    var vin = ""
    var make = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        carNameLabel.text = (passedCar[1] as! String)
        priceLabel.text = "\(passedCar[4])"
        yearLabel.text = (passedCar[0] as! String)
        trimLabel.text = (passedCar[2] as! String)
        mileageLabel.text = "\(passedCar[5])"
        vinLabel.text = vin
        if((passedCar[8] as! String) == "")
        {
            
        }
        else
        {
            notesTextView.text = (passedCar[8] as! String)
        }
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.region = MKCoordinateRegionMakeWithDistance(locationManager.location!.coordinate, 1000, 1000)
        dropPin()
        
    }
    
    func dropPin()
    {
        if((passedCar[6] as! Double) != 0 || (passedCar[7] as! Double) != 0)
        {
            let location = CLLocationCoordinate2DMake((passedCar[7] as! Double),(passedCar[6] as! Double))
            
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = location
            dropPin.title = "Car Location"
            mapView.addAnnotation(dropPin)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dict = applicationDelegate.make_dict_cars[make] as! NSMutableDictionary
        let array = dict[vin] as! NSMutableArray
        array[8] = textView.text
        dict.setValue(array, forKey: vin)
        applicationDelegate.make_dict_cars.setValue(dict, forKey: make)
        
    }
    
    
    @IBAction func tappedKeyboardDismiss(sender: UITapGestureRecognizer) {
        notesTextView.resignFirstResponder()
    }

    @IBAction func kbbPressed(sender: UIButton) {
        performSegueWithIdentifier("toKBB", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dvc = segue.destinationViewController as! KBBWebViewController
        dvc.vin = vin
    }

    
    //MARKL - MAPKIT
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        // Below condition is for custom annotation
        if (annotation.isKindOfClass(CustomAnnotation)) {
            let customAnnotation = annotation as? CustomAnnotation
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation") as MKAnnotationView!
            
            if (annotationView == nil) {
                annotationView = customAnnotation?.annotationView()
            } else {
                annotationView.annotation = annotation;
            }
            
            return annotationView
        } else {
            return nil
        }
    }

    @IBAction func updateLocation(sender: UIBarButtonItem) {
        let long = locationManager.location!.coordinate.longitude
        let lat = locationManager.location!.coordinate.latitude
        let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dict = applicationDelegate.make_dict_cars[make] as! NSMutableDictionary
        let array = dict[vin] as! NSMutableArray
        array[6] = long 
        array[7] = lat 
        
        dict.setValue(array, forKey: vin)
        applicationDelegate.make_dict_cars.setValue(dict, forKey: make)
        
        dropPin()
        
        
    }
    
    
    //MARK: - MESSAGE UI
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["manager@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail" + " For \(passedCar[0]) \(passedCar[1])")
        mailComposerVC.setMessageBody("Current asking price is \(passedCar[4]) they want ...", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "OOPS", message: "Looks like your email isnt set up",
            preferredStyle: UIAlertControllerStyle.Alert)
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
