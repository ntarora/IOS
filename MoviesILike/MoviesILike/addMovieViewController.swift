//
//  addMovieViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/16/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class addMovieViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var movieNameTextField: UITextField!
    @IBOutlet var topStarsTextField: UITextField!
    @IBOutlet var movieGenreTextField: UITextField!
    @IBOutlet var movieTrailerTextField: UITextField!
    @IBOutlet var rating: UISegmentedControl!

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

}
