//
//  MyTheatersMapViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/17/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MyTheatersMapViewController: UIViewController, UIWebViewDelegate {
    
    // This property contains the absolute file path for the maps.html file
    var mapsHtmlFilePath: String?
    
    @IBOutlet var webView: UIWebView!
    
    var nameOfPlace : String?
    var addressNoSpaces : String?
    var type : Int?
    
    /*
    -----------------------
    MARK: - View Life Cycle
    -----------------------
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Obtain the absolute file path to the maps.html file in the main bundle
        mapsHtmlFilePath = NSBundle.mainBundle().pathForResource("maps", ofType: "html")
        /*
        println("mapsHtmlFilePath = \(mapsHtmlFilePath)")
        
        This prints the following as the *** absolute path *** to the maps.html file.
        
        mapsHtmlFilePath = Optional("/Users/Balci/Library/Developer/CoreSimulator/Devices/230B3A00-3615-486F-A925-D601DB35F0FC/
        data/Containers/Bundle/Application/1BBEB6E1-FA8A-4179-BA6E-E85CC355679F/VTQuest.app/maps.html")
        */
        addressNoSpaces = nameOfPlace!.stringByReplacingOccurrencesOfString(" ", withString: "+", options: [], range: nil)
        setMapType(type!)
        
    }
    
    /*
    --------------------
    MARK: - Set Map Type
    --------------------
    */
    // This method is invoked when the user selects a map type to display
    func setMapType(sender: Int) {
        
        switch sender{
            
        case 0:   // Roadmap map type selected
            let googleMapQuery = mapsHtmlFilePath! + "?place=\(addressNoSpaces!)&maptype=ROADMAP&zoom=16"
            showMap(googleMapQuery)
            
        case 1:   // Satellite map type selected
            let googleMapQuery = mapsHtmlFilePath! + "?place=\(addressNoSpaces!)&maptype=SATELLITE&zoom=16"
            showMap(googleMapQuery)
            
        case 2:   // Hybrid map type selected
            let googleMapQuery = mapsHtmlFilePath! + "?place=\(addressNoSpaces!)&zoom=16&maptype=HYBRID"
            showMap(googleMapQuery)
            
        case 3:   // Terrain map type selected
            let googleMapQuery = mapsHtmlFilePath! + "?place=\(addressNoSpaces!)&maptype=TERRAIN&zoom=16"
            showMap(googleMapQuery)
            
        default:
            return
        }
    }
    
    /*
    ----------------
    MARK: - Show Map
    ----------------
    */
    // This method displays the map within a web view object
    func showMap(mapQuery: String) {
        
        /*
        Convert the mapQuery into an NSURL object and store its object reference into the local variable url.
        An NSURL object represents a URL.
        */
        let url: NSURL? = NSURL(string: mapQuery)
        
        /*
        Convert the NSURL object into an NSURLRequest object and store its object
        reference into the local variable request. An NSURLRequest object represents
        a URL load request in a manner independent of protocol and URL scheme.
        */
        let request = NSURLRequest(URL: url!)
        
        // Ask the webView object to display the web page for the given URL
        webView.loadRequest(request)
    }
    
    /*
    ----------------------------------
    MARK: - UIWebView Delegate Methods
    ----------------------------------
    */
    func webViewDidStartLoad(webView: UIWebView) {
        // Starting to load the web page. Show the animated activity indicator in the status bar
        // to indicate to the user that the UIWebVIew object is busy loading the web page.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // Finished loading the web page. Hide the activity indicator in the status bar.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        /*
        Ignore this error if the page is instantly redirected via javascript or in another way.
        NSURLErrorCancelled is returned when an asynchronous load is cancelled, which happens
        when the page is instantly redirected via javascript or in another way.
        */
        if error!.code == NSURLErrorCancelled {
            return
        }
        
        // An error occurred during the web page load. Hide the activity indicator in the status bar.
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        // Create the error message in HTML as a character string and store it into the local constant errorString
        let errorString = "<html><font size=+2 color='red'><p>An error occurred: <br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>" + error!.localizedDescription
        
        // Display the error message within the UIWebView object
        // self. is required here since this method has a parameter with the same name.
        self.webView.loadHTMLString(errorString, baseURL: nil)
    }
    
}
