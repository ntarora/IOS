//
//  MyGenresWebViewController.swift
//  MoviesILike
//
//  Created by Neel A on 11/17/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class MyGenresWebViewController:  UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    
    var youtube : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        let url = "http://www.youtube.com/embed/\(youtube!)"
        
        let nurl = NSURL(string: url)
        
        let requst = NSURLRequest(URL: nurl!)
        
        webView.loadRequest(requst)
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
