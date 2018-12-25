//
//  InterstitialViewController.swift
//  Mraid-Sample
//
//  Created by dev on 19/07/18.
//  Copyright © 2018 InspireMobile. All rights reserved.
//

import UIKit
import byInspired


class InterstitialViewController: UIViewController,SKMRAIDServiceDelegate,SKMRAIDInterstitialDelegate,UITextFieldDelegate
{
     var app = AppDelegate()
    var interstitiaOpenString = NSString()
    var interstitial = SKMRAIDInterstitial()
    
    var tagNmbr = NSString()
    var keyString = NSString()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        app = UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        interstitial .isViewable = true
        
        self .appActiveMode()
    }
    
//********************** INTERSTITIAL START ********************

    func showInterstitial()
    {
        
//        let myURLString = "http://hexims.it/work/inspire/banneri.html"
//        var htmlData = NSString()
//        do {
//            htmlData = try String (contentsOf: NSURL(string: myURLString)! as URL, encoding: String.Encoding.utf8) as NSString
//            print(htmlData)
//        }
//        catch
//        {
//            print(error)
//        }
//
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

            interstitiaOpenString = htmlData as NSString
            
            let bundleUrl = NSURL(fileURLWithPath: Bundle.main .bundlePath)
            interstitial = interstitial .initWithSupportedFeatures(features: [Constants.MRAIDSupportsSMS,   Constants.MRAIDSupportsStorePicture, Constants.MRAIDSupportsInlineVideo], withHtmlData: interstitiaOpenString , withBaseURL: bundleUrl, delegat: self, serviceDelegat: self, rootViewControllerr: self) as! SKMRAIDInterstitial
        }
        catch
        {
            print ("File HTML error")
        }
    }
    
    func appActiveMode()
     {
//        // Notification when app will resign active or did became active
//        NotificationCenter.default.addObserver(self,selector: #selector(applicationWillResignActive), name: .UIApplicationWillResignActive,object: nil)
//        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: .UIApplicationDidBecomeActive,object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification,object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: UIApplication.didBecomeActiveNotification,object: nil)
        
     }
//************************ INTERSTITIAL END ********************
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
//****************CLICK BTN TO OPEN INTERTITIAL ****************

    @IBAction func showInterstitial(_ sender: Any)
    {
        tagNmbr = String(format: "tag=\"%@\"",app.interstitialTag) as NSString
        keyString = String(format: "key=\"%@\"",app.interstitialKey) as NSString
        
        print(tagNmbr)
        self .showInterstitial()
    }
  
//*********************GO BANNER SCREEN ******************

    @IBAction func goBannerScreen(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
  
//************ APPLICATION ACTIVE NOTIFICATION START ***********
    
    @objc func applicationWillResignActive(notification: UIApplication)
    {
        interstitial.isViewable = false
    }
    
    @objc func applicationDidBecomeActive(notification: UIApplication)
    {
        interstitial.isViewable = true
    }
//************* APPLICATION ACTIVE NOTIFICATION END ************

//********************DELEGATE METHOD START********************
   
// Mraid Interstitial Open With Url
    func mraidServiceOpenBrowserWithUrlString(urlString: NSString)
    {
        if let url = URL(string: "\(urlString)")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

func mraidServiceStorePictureWithUrlString(urlString: NSString)
    {
        print("LOG")
    }
    
// Mraid Interstitial Ready
    func mraidInterstitialAdReady(mraidInterstitial: SKMRAIDInterstitial)
    {
        interstitial .show()
        
    }
    
// Mraid Interstitial Failed
    func mraidInterstitialAdFailed(mraidInterstitial: SKMRAIDInterstitial)
    {
         print("Failed")
    }

// Mraid Interstitial Will Show

    func mraidInterstitialWillShow(mraidInterstitial: SKMRAIDInterstitial)
    {
         print("")
    }
    
// Mraid Interstitial Hide Not Ready

    func mraidInterstitialDidHide(mraidInterstitial: SKMRAIDInterstitial)
    {
        print("Status: Not Ready")
        self.navigationController?.popViewController(animated: true)
    }
    
    func mraidInterstitialNavigate(mraidInterstitial: SKMRAIDInterstitial, withURL url: NSURL)
    {
        
    }
    //********************DELEGATE METHOD END******************
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
}

