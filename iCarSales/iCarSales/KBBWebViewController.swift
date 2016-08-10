//
//  KBBWebViewController.swift
//  iCarSales
//
//  Created by Neel A on 12/9/15.
//  Copyright © 2015 Neel Arora. All rights reserved.
//

import UIKit

class KBBWebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    var vin = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         let websiteURL = "http://www.cargurus.com/Cars/instantMarketValueFromVIN.action?startUrl=%2F&carDescription.vin=\(vin)"
        
        /*
        * Convert the URL entered by the user into an NSURL object and store its object
        * reference into the local variable url. An NSURL object represents a URL.
        */
        let url = NSURL(string: websiteURL)
        
        /*
        * Convert the NSURL object into an NSURLRequest object and store its object
        * reference into the local variable request. An NSURLRequest object represents
        * a URL load request in a manner independent of protocol and URL scheme.
        */
        let request = NSURLRequest(URL: url!)
        
        // Ask the web view object to display the web page for the URL entered by the user.
        webView.loadRequest(request)
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
    
    // These methods must be implemented whenever UIWebView is used.
    
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
        self.webView.loadHTMLString(errorString, baseURL: nil)
    }

}
