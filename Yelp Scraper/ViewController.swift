//
//  ViewController.swift
//  Yelp Scraper
//
//  Created by Morris Richman on 3/5/23.
//

import UIKit
import WebKit
import SwiftSoup

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let config = WKWebViewConfiguration()
        let pref = WKWebpagePreferences()
        pref.preferredContentMode = .desktop
        config.defaultWebpagePreferences = pref
        self.webView = WKWebView(frame: .zero, configuration: config)
        self.webView.navigationDelegate = self
        view = webView
        
        let url = URL(string: "https://www.yelp.com/biz/kedai-makan-seattle-4")!
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Task {
            await getAmmenities(webView: webView)
        }
    }
    
    func getAmmenities(webView: WKWebView) async {
        do {
            
            let result = try await webView.evaluateJavaScript("document.body.innerHTML")
            guard let html = result as? String else {
                print("Failed to get HTML")
                return
            }
                let doc: Document = try SwiftSoup.parse(html)
                let sections: Elements = try doc.select("section")
            for section in sections {
                let sectionLabel: String = try section.attr("aria-label")
                if sectionLabel.contains("Amenities and More") {
                    print("Found It!")
                    let ammenitiesSection = section
                    let divs: Elements = try ammenitiesSection.select("div")
                    let divArray = Array(Set(try divs.eachText()))
                    let ammenities = divArray.filter { str in
                        str.count < 50 && str != "Amenities and More"
                    }
                    break
                }
            }
        } catch {
            
        }
    }
    
}

