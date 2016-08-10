//
//  AddMyTheaterViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/19/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class AddMyTheaterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var movieTheaterName: UITextField!
    @IBOutlet var movieTheaterAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func tappedBackground(sender: UITapGestureRecognizer) {
        movieTheaterAddress.resignFirstResponder()
        movieTheaterName.resignFirstResponder()
        
    }
    
}
