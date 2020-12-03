//
//  ViewController.swift
//  ConnectWrapper
//
//  Copyright © 2020 finicity. All rights reserved.
//

import UIKit
import Connect

class ViewController: UIViewController {

    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var connectViewController: ConnectViewController!
    var connectNavController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Query Connect.xcframework for SDK version.
        print("Connect.xcframework SDK version: \(sdkVersion())")
    }
    
    @IBAction func startButtonClicked(_ sender: UIButton) {
        activityIndicator.startAnimating()
        self.openWebKitConnectView()
    }
    
    func openWebKitConnectView() {
        if let connectUrl = urlInput.text {
            let config = ConnectViewConfig(connectUrl: connectUrl, loaded: self.connectViewLoaded, done: self.connectViewDone, cancel: self.connectViewCancelled, error: self.connectViewError, route: self.connectViewRoute, userEvent: self.connectViewUserEvent)
            
            print("creating & loading connectViewController")
            self.connectViewController = ConnectViewController()
            self.connectViewController.load(config: config)
        } else {
            print("no connect url provided.")
            activityIndicator.stopAnimating()
        }
    }
    
    func connectViewLoaded() {
        print("connectViewController loaded")
        self.connectNavController = UINavigationController(rootViewController: self.connectViewController)
        self.connectNavController.modalPresentationStyle = .automatic
        self.connectNavController.presentationController?.delegate = self
        self.present(self.connectNavController, animated: false)
    }
    
    func connectViewDone(_ data: NSDictionary?) {
        print("connectViewController done")
        print(data?.debugDescription ?? "no data in callback")
        self.activityIndicator.stopAnimating()
    }
    
    func connectViewCancelled() {
        print("connectViewController cancel")
        self.activityIndicator.stopAnimating()
    }
    
    func connectViewError(_ data: NSDictionary?) {
        print("connectViewController error")
        print(data?.debugDescription ?? "no data in callback")
        self.activityIndicator.stopAnimating()
    }
    
    func connectViewRoute(_ data: NSDictionary?) {
        print("connectViewController route")
        print(data?.debugDescription ?? "no data in callback")
    }
    
    func connectViewUserEvent(_ data: NSDictionary?) {
        print("connectViewController user")
        print(data?.debugDescription ?? "no data in callback")
    }
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("connectViewController dismissed by gesture")
        self.activityIndicator.stopAnimating()
    }
}

