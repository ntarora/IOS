//
//  MyMoviesTableViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/16/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MyMoviesTableViewController: UITableViewController {
    
    var allGenres = [String]()
    var dict_Genere_dic1 = NSMutableDictionary()
    var youtubePass : String?
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/MyFavoriteMovies.plist"
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInDocumentDirectory)
        if let dictionaryFromFileInDocumentDirectory = dictionaryFromFile {
            
            // CountryCities.plist exists in the Documents directory
            dict_Genere_dic1 = dictionaryFromFileInDocumentDirectory
            allGenres = dict_Genere_dic1.allKeys as! [String]
            
        } else {
            
            // CountryCities.plist does not exist in the Documents directory; Read it from the main bundle.
            
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let plistFilePathInMainBundle = NSBundle.mainBundle().pathForResource("MyFavoriteMovies", ofType: "plist")
            
            // Assign it to the instance variable
            let dictionary1: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInMainBundle!)
            dict_Genere_dic1 = dictionary1!
            allGenres = dictionary1!.allKeys as! [String]
        }
        
        /*
        NSDictionary manages an *unordered* collection of key-value pairs.
        Instantiate an NSDictionary object and initialize it with the contents of the accSports.plist file.
        */
        
        
        
        
        
        
           // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return allGenres.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let key = allGenres[section];
        
        let dictOfMovies = dict_Genere_dic1[key] as! NSDictionary
        let movieArrayKeys = dictOfMovies.allKeys as! [String]
        
        return movieArrayKeys.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allGenres[section]
    }
    
    /*
    ----------------------------------------------
    MARK: - Unwind Segue Method
    ----------------------------------------------
    */
    @IBAction func unwindToMovieTableViewController (segue : UIStoryboardSegue) {
        
        if segue.identifier == "AddMovie-Save" {
            // Obtain the object reference of the source view controller
            let controller: addMovieViewController = segue.sourceViewController as! addMovieViewController
            let alertController = UIAlertController(title: "OOPS", message: "Fill all text fields",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            // Create a UIAlertAction object and add it to the alert controller
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
           
            if(controller.movieNameTextField.text == "")
            {
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            if(controller.topStarsTextField.text == "")
            {
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            if(controller.movieGenreTextField.text == "")
            {
                // Present the alert controller by calling the presentViewController method
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            if(controller.movieTrailerTextField.text == "")
            {
                // Present the alert controller by calling the presentViewController method
                presentViewController(alertController, animated: true, completion: nil)
                return
            }
            
            if(allGenres.contains(controller.movieGenreTextField.text!))
            {
                let movies = dict_Genere_dic1[controller.movieGenreTextField.text!] as! NSMutableDictionary
                //let newMove = NSMutableDictionary()
                //let array : NSArray = NSArray(array: [controller.movieNameTextField.text!, controller.topStarsTextField.text!, controller.movieTrailerTextField.text!,controller.rating.titleForSegmentAtIndex(controller.rating.selectedSegmentIndex)!])
                let array = [controller.movieNameTextField.text!, controller.topStarsTextField.text!, controller.movieTrailerTextField.text!,controller.rating.titleForSegmentAtIndex(controller.rating.selectedSegmentIndex)!]
                
                movies.setValue(array, forKey: controller.movieNameTextField.text!)
                dict_Genere_dic1.setValue(movies, forKey: controller.movieGenreTextField.text!)
                
                // Define the file path to the CountryCities.plist file in the Documents directory
                let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                let documentDirectoryPath = paths[0] as String
                
                // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
                let plistFilePathInDocumentDirectory = documentDirectoryPath + "/MyFavoriteMovies.plist"
                
                // Write the NSMutableDictionary to the CountryCities.plist file in the Documents directory
                dict_Genere_dic1.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
                
            }
            self.tableView.reloadData()
            
            
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as!MyMovieTableViewCell
        
        let key = allGenres[indexPath.section]
        
        let dictOfMovies = dict_Genere_dic1[key] as! NSDictionary
        let movieArrayKeys = dictOfMovies.allKeys as! [String]
        let key2 = movieArrayKeys[indexPath.row]
        let arrayMovie = dictOfMovies[key2] as! NSArray
        
        cell.imageView?.image = UIImage(named: arrayMovie[3] as! String)
        cell.movieNameLabel.text = (arrayMovie[0] as! String)
        cell.actorsLabel.text = (arrayMovie[1] as! String)
        

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let key = allGenres[indexPath.section]
        
        let dictOfMovies = dict_Genere_dic1[key] as! NSDictionary
        let movieArrayKeys = dictOfMovies.allKeys as! [String]
        let key2 = movieArrayKeys[indexPath.row]
        let arrayMovie = dictOfMovies[key2] as! NSArray
        
        youtubePass = (arrayMovie[2] as! String)
        
        
        performSegueWithIdentifier("toTrailer", sender: self)
        
    }
    
    
    //-------------------------------
    // Allow Editing of Rows (Cities)
    //-------------------------------
    
    // We allow each row (city) of the table view to be editable, i.e., deletable or movable
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    //---------------------
    // Delete Button Tapped
    //---------------------
    
    // This is the method invoked when the user taps the Delete button in the Edit mode
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         if editingStyle == .Delete {
            
            let key = allGenres[indexPath.section]
            
            let dictOfMovies = dict_Genere_dic1[key] as! NSMutableDictionary
            let movieArrayKeys = dictOfMovies.allKeys as! [String]
            let key2 = movieArrayKeys[indexPath.row]
            //let arrayMovie = dictOfMovies[key2] as! NSArray
            
            dictOfMovies.removeObjectForKey(key2)
            
            dict_Genere_dic1.setValue(dictOfMovies, forKey: key)
            
            // Define the file path to the CountryCities.plist file in the Documents directory
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDirectoryPath = paths[0] as String
            
            // Add the plist filename to the documents directory path to obtain an absolute path to the plist filename
            let plistFilePathInDocumentDirectory = documentDirectoryPath + "/MyFavoriteMovies.plist"
            
            // Write the NSMutableDictionary to the CountryCities.plist file in the Documents directory
            dict_Genere_dic1.writeToFile(plistFilePathInDocumentDirectory, atomically: true)
            
            tableView.reloadData()
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func editPressed(sender: UIBarButtonItem) {
        if(editing == true)
        {
            setEditing(false, animated: true)
        }
        else
        {
            setEditing(true, animated: true)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.\
        if(segue.identifier == "toTrailer")
        {
            let dvc = segue.destinationViewController as! MyMoviesWebViewController
            dvc.youtube = youtubePass!
        }
       
    }

}
