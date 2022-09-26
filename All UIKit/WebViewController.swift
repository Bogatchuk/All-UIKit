//
//  WebViewController.swift
//  All UIKit
//
//  Created by Roma Bogatchuk on 25.09.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.google.com"
        
        let url = URL(string: homePage)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        textField.text = homePage
        
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
            textField.text = webView.url?.absoluteString
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: UIButton) {
        if webView.canGoForward{
            webView.goForward()
            print("go")
            textField.text = webView.url?.absoluteString
        }else {
            print("dgo")
        }
        
        print("dccgo")
    }
    

}

extension WebViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        textField.resignFirstResponder()//скрываем клавиатуру после нажаните на return
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(webView.url?.absoluteString)
        textField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}


