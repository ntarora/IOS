//
//  MovieSearchViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/16/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var Search: UITextField!
    var movie :String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Designate self as a subscriber to Keyboard Notifications
        registerForKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    ---------------------------------------
    MARK: - Handling Keyboard Notifications
    ---------------------------------------
    */
    
    // This method is called in viewDidLoad() to register self for keyboard notifications
    func registerForKeyboardNotifications() {
        
        // "An NSNotificationCenter object (or simply, notification center) provides a
        // mechanism for broadcasting information within a program." [Apple]
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self,
            selector:   "textFieldDidBeginEditing:",    // <-- Call this method upon Keyboard Will SHOW Notification
            name:       UIKeyboardWillShowNotification,
            object:     nil)
        
        notificationCenter.addObserver(self,
            selector:   "textFieldDidBeginEditing:",    //  <-- Call this method upon Keyboard Will HIDE Notification
            name:       UIKeyboardWillHideNotification,
            object:     nil)
    }
    
    
    // This method is called when the user taps Return on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        // Deactivate the text field and remove the keyboard
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
//        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }

    /*
    ---------------------------------------------
    MARK: - Register and Unregister Notifications
    ---------------------------------------------
    */
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    @IBAction func searchPressed(sender: UIButton) {
        if(Search.text == "")
        {
            let alert = UIAlertController(title: "Oops!", message: "Please enter a value in the search", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        else
        {
            movie = Search.text
            performSegueWithIdentifier("toMovies", sender: self)
        }
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       let dvc = segue.destinationViewController as! MoviesTableViewController
        dvc.movieNameToSearch = movie
    }
    @IBAction func dismissKeyBoard(sender: UITapGestureRecognizer) {
        Search.resignFirstResponder()
    }
    
}


