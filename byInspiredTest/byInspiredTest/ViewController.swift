//
//  ViewController.swift
//  Demo_MRAID
//
//  Created by dev on 21/11/18.
//  Copyright © 2018 hexims. All rights reserved.
//

import UIKit
import byInspired

//SKMRAIDModalViewControllerDelegate

class ViewController: UIViewController,SKMRAIDViewDelegate,SKMRAIDServiceDelegate,SKBrowserDelegate,SKMRAIDModalViewControllerDelegate,UITextFieldDelegate
{
    
    var app = AppDelegate()
    var adView = SKMRAIDView2()
    var browser = SKBrowser2()
    var bannerOpenString = NSString()
    var tagNmbr = NSString()
    var keyString = NSString()
    
    // @IBOutlet weak var keyTF: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        app = UIApplication.shared.delegate as! AppDelegate
        
        //  keyTF .delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self .appActiveMode()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func appActiveMode()
    {
        NotificationCenter.default.addObserver(self,selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification,object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: UIApplication.didBecomeActiveNotification,object: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //********************CLICK BTN TO OPEN BANNER *****************
    @IBAction func showBannerView(_ sender: Any)
    {
        tagNmbr = String(format: "tag=\"%@\"",app.bannerTag) as NSString
        keyString = String(format: "key=\"%@\"",app.bannerKey) as NSString
        self .showBannerData()
    }
    //************************** BANNER*************************
    
    func showBannerData()
    {
        do {
            guard let filePath = Bundle.main.path(forResource: "banner", ofType: "html")
                
                else {
                    print ("File reading error")
                    return
            }
            var htmlData =  try String(contentsOfFile: filePath, encoding: .utf8)
            print(htmlData)
            
            htmlData = htmlData.replacingOccurrences(of: "tag=\"\"", with: tagNmbr as String)
            print(htmlData)
            htmlData = htmlData.replacingOccurrences(of: "key=\"\"", with: keyString as String)
            print(htmlData)
            
            bannerOpenString = htmlData as NSString
            let bundleUrl = NSURL(fileURLWithPath: Bundle.main .bundlePath)
            adView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100)
            adView = adView .initWithFrame(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100), withHtmlData: bannerOpenString, withBaseURL: bundleUrl, supportedFeatures: [Constants.MRAIDSupportsSMS, Constants.MRAIDSupportsStorePicture], delegate: self, serviceDelegate: self, rootViewController: self) as! SKMRAIDView2
            self.view .addSubview(adView)
        }
        catch {
            print ("File HTML error")
        }
    }
    
    
    //*********************GO INTERSTITIAL SCREEN ******************
    
    @IBAction func goInterstitialScreen(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Interstitial") as! InterstitialViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //************ APPLICATION ACTIVE NOTIFICATION START ***********
    
    @objc func applicationWillResignActive(notification: UIApplication)
    {
        // hide banner view
        adView .isViewable = false
    }
    
    @objc func applicationDidBecomeActive(notification: UIApplication)
    {
        // show banner view
        adView .isViewable = true
    }
    //************ APPLICATION ACTIVE NOTIFICATION END ***********
    
    
    //********************DELEGATE METHOD START****************
    
    
    //If Mraid Ready
    func mraidViewAdReady(mraidView: SKMRAIDView2)
    {
        print("")
    }
    
    //If Mraid Failed
    func mraidViewAdFailed(mraidView: SKMRAIDView2)
    {
        print("")
    }
    
    //If Mraid Expand
    func mraidViewWillExpand(mraidView: SKMRAIDView2)
    {
        print("")
    }
    
    //If Mraid Closed
    func mraidViewDidClose(mraidView: SKMRAIDView2)
    {
        print("")
    }
    
    //If Mraid Navigate with url
    func mraidViewNavigate(mraidView: SKMRAIDView2, withURL url: NSURL) {
        print("")
    }
    
    func MRAIDForceOrientationFromString(s: NSString) -> SKMRAIDForceOrientation
    {
        return SKMRAIDForceOrientation.MRAIDForceOrientationPortrait
    }
    
    func mraidViewShouldResize(mraidView: SKMRAIDView2, toPosition position: CGRect, allowOffscreen: Bool) -> Bool
    {
        return true
    }
    
    //If Mraid is "open"
    func mraidServiceOpenBrowserWithUrlString(urlString: NSString) {
        browser = browser .initWithDelegate(delegate: self, withFeatures: [Constant.kSourceKitBrowserFeatureSupportInlineMediaPlayback
            , Constant.kSourceKitBrowserFeatureDisableStatusBar
            , Constant.kSourceKitBrowserFeatureScalePagesToFit]) as! SKBrowser2
        let myURL = URL(string: urlString as String)
        let myRequest = URLRequest(url: myURL!)
        browser .loadRequest(request: myRequest as NSURLRequest)
    }
    
    //If Mraid Storepicture
    func mraidServiceStorePictureWithUrlString(urlString: NSString)
    {
        print("")
    }
    
    func mraidModalViewControllerDidRotate(modalViewController: SKMRAIDModalViewController)
    {
        print("Rotate")
    }
    
    //If Mraid Closed from browser
    func sourceKitBrowserClosed(sourceKitBrowser: SKBrowser2) {
        self .dismiss(animated: true)
        {
            self .navigationController?.popViewController(animated: true)
        }
    }
    
    func sourceKitBrowserWillExitApp(sourceKitBrowser: SKBrowser2)
    {
        print("")
    }
    //********************DELEGATE METHOD END******************
    
    
}



