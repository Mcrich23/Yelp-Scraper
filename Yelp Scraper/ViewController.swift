//
//  ViewController.swift
//  Yelp Scraper
//
//  Created by Morris Richman on 3/5/23.
//

import UIKit
import WebKit
import SwiftSoup

class ViewController: UIViewController {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.webView = WKWebView()
        view = webView
        
        let url = URL(string: "https://www.yelp.com/biz/kedai-makan-seattle-4")!
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    func getAmmenities() {
        do {
            let html: String = "<p>An <a href='http://example.com/'><b>example</b></a> link.</p>"
                let doc: Document = try SwiftSoup.parse(html)
                let link: Element = try doc.select("a").first()!
                
                let text: String = try doc.body()!.text() // "An example link."
                let linkHref: String = try link.attr("href") // "http://example.com/"
                let linkText: String = try link.text() // "example"
                
                let linkOuterH: String = try link.outerHtml() // "<a href="http://example.com/"><b>example</b></a>"
                let linkInnerH: String = try link.html() // "<b>example</b>"
        } catch {
            
        }
    }
    
}

