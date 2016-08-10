//
//  MyGenresViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/16/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MyGenresViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

    var allGenres = [String]()
    var dict_Genere_dic1 = NSDictionary()
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    
    var youtubePass : String?
    // Other properties (instance variables) and their initializations
    let kScrollMenuHeight: CGFloat = 30.0
    var selectedAutoMaker = ""
    var previousButton = UIButton(frame: CGRectMake(0, 0, 0, 0))
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Obtain the URL to the accSports.plist file in subdirectory "plist Files"
        let PlistURL : NSURL? = NSBundle.mainBundle().URLForResource("MyFavoriteMovies", withExtension: "plist")
        
        /*
        NSDictionary manages an *unordered* collection of key-value pairs.
        Instantiate an NSDictionary object and initialize it with the contents of the accSports.plist file.
        */
        let dictionary1: NSDictionary? = NSDictionary(contentsOfURL: PlistURL!)
        dict_Genere_dic1 = dictionary1!
        allGenres = dictionary1!.allKeys as! [String]
        
        
        
        
        
        
        
        scrollView.backgroundColor = UIColor.blackColor()
        
        /***********************************************************************
         * Instantiate and setup the buttons for the horizontally scrollable menu
         ***********************************************************************/
         
         // Instantiate a mutable array to hold the menu buttons to be created
        var listOfMenuButtons = [UIButton]()
        
        for var i = 0; i < allGenres.count; i++ {
            
            // Instantiate a button to be placed within the horizontally scrollable menu
            let scrollMenuButton = UIButton(type: UIButtonType.Custom)
            
            // Obtain the title (i.e., auto manufacturer name) to be displayed on the button
            let buttonTitle = allGenres[i]
            
            // The button width and height in points will depend on its font style and size
            let buttonTitleFont = UIFont(name: "Helvetica-Bold", size: 17.0)
            
            // Set the font of the button title label text
            scrollMenuButton.titleLabel?.font = buttonTitleFont
            
            // Compute the size of the button title in points
            let buttonTitleSize: CGSize = (buttonTitle as NSString).sizeWithAttributes([NSFontAttributeName:buttonTitleFont!])
            
            // Add 20 points to the width to leave 10 points on each side.
            // Set the button frame with width=buttonWidth height=kScrollMenuHeight points with origin at (x, y) = (0, 0)
            scrollMenuButton.frame = CGRectMake(0.0, 0.0, buttonTitleSize.width + 20.0, kScrollMenuHeight)
            
            // Set the background color of the button to black
            scrollMenuButton.backgroundColor = UIColor.blackColor()
            
            // Set the button title to the automobile manufacturer's name
            scrollMenuButton.setTitle(buttonTitle, forState: UIControlState.Normal)
            
            // Set the button title color to white
            scrollMenuButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            
            // Set the button title color to red when the button is selected
            scrollMenuButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
            
            // Set the button to invoke the buttonPressed: method when the user taps it
            scrollMenuButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
            
            // Add the constructed button to the list of buttons
            listOfMenuButtons.append(scrollMenuButton)
        }
        
        /*********************************************************************************************
         * Compute the sumOfButtonWidths = sum of the widths of all buttons to be displayed in the menu
         *********************************************************************************************/
        
        var sumOfButtonWidths: CGFloat = 0.0
        
        for var j = 0; j < listOfMenuButtons.count; j++ {
            
            // Obtain the obj ref to the jth button in the listOfMenuButtons array
            let button: UIButton = listOfMenuButtons[j]
            
            // Set the button's frame to buttonRect
            var buttonRect: CGRect = button.frame
            
            // Set the buttonRect's x coordinate value to sumOfButtonWidths
            buttonRect.origin.x = sumOfButtonWidths
            
            // Set the button's frame to the newly specified buttonRect
            button.frame = buttonRect
            
            // Add the button to the horizontally scrollable menu
            scrollView.addSubview(button)
            
            // Add the width of the button to the total width
            sumOfButtonWidths += button.frame.size.width
        }
        
        // Horizontally scrollable menu's content width size = the sum of the widths of all of the buttons
        // Horizontally scrollable menu's content height size = kScrollMenuHeight points
        scrollView.contentSize = CGSizeMake(sumOfButtonWidths, kScrollMenuHeight)
        
        /*******************************************************
        * Select and show the default auto maker upon app launch
        *******************************************************/
        
        // Hide left arrow
        //leftArrowWhite.hidden = true
        
        // The first auto maker on the list is the default one to display
        let defaultButton: UIButton = listOfMenuButtons[0]
        
        // Indicate that the button is selected
        defaultButton.selected = true
        
        previousButton = defaultButton
        selectedAutoMaker = allGenres[0]
        
        // Display the table view object's content for the selected auto maker
        tableView.reloadData()
    }
    
    /*
    -----------------------------------
    MARK: - Method to Handle Button Tap
    -----------------------------------
    */
    // This method is invoked when the user taps a button in the horizontally scrollable menu
    func buttonPressed(sender: UIButton) {
        
        let selectedButton: UIButton = sender
        
        selectedButton.selected = true
        
        if previousButton != selectedButton {
            // Selecting the selected button again should not change its title color
            previousButton.selected = false
        }
        
        previousButton = selectedButton
        
        selectedAutoMaker = selectedButton.titleForState(UIControlState.Normal)!
        
        // Redisplay the table view object's content for the selected auto maker
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dictOfMovies = dict_Genere_dic1[selectedAutoMaker] as! NSDictionary
        let movieArrayKeys = dictOfMovies.allKeys as! [String]
        
        return movieArrayKeys.count
    }
    
    /*
    -----------------------------------
    MARK: - Scroll View Delegate Method
    -----------------------------------
    */
    
    // Tells the delegate when the user scrolls the content view within the receiver
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // The autoTableView object scrolling also invokes this method, in the case of which no action
        // should be taken since this method is created to handle only the scrollMenu object's scrolling.
        
    }
    
    // Asks the data source to return a cell to insert in a particular table view location
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("genreCell", forIndexPath: indexPath) as! MyGenreTableViewCell
        
        
        let dictOfMovies = dict_Genere_dic1[selectedAutoMaker] as! NSDictionary
        let movieArrayKeys = dictOfMovies.allKeys as! [String]
        let key2 = movieArrayKeys[indexPath.row]
        let arrayMovie = dictOfMovies[key2] as! NSArray
        
        cell.imageView?.image = UIImage(named: arrayMovie[3] as! String)
        cell.movieNameLabel.text = (arrayMovie[0] as? String)
        cell.actorsLabel.text = (arrayMovie[1] as? String)
        
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.\
        let dvc = segue.destinationViewController as! MyGenresWebViewController
        dvc.youtube = youtubePass!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictOfMovies = dict_Genere_dic1[selectedAutoMaker] as! NSDictionary
        let movieArrayKeys = dictOfMovies.allKeys as! [String]
        let key2 = movieArrayKeys[indexPath.row]
        let arrayMovie = dictOfMovies[key2] as! NSArray
        
        youtubePass = (arrayMovie[2] as! String)
        
        performSegueWithIdentifier("toTrailer2", sender: self)
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
