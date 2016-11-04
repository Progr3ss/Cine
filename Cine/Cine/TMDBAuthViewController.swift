////
////  TMDBAuthViewController.swift
////  Cine
////
////  Created by martin chibwe on 10/8/16.
////  Copyright © 2016 Martin Chibwe. All rights reserved.
////
//
//import UIKit
//
//class TMDBAuthViewController: UIViewController {
//
//	
//	
//	// MARK: Properties
//	
//	var urlRequest: NSURLRequest? = nil
//	var requestToken: String? = nil
//	var completionHandlerForView: ((_ success: Bool, _ errorString: String?) -> Void)? = nil
//	
//	@IBOutlet weak var webView: UIWebView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//		webView.delegate = self
//		
//		navigationItem.title = "TheMovieDB Auth"
//		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAuth))
//
//        // Do any additional setup after loading the view.
//    }
//	
//	override func viewWillAppear(_ animated: Bool) {
//		super.viewWillAppear(animated)
//		
//		if let urlRequest = urlRequest {
//			webView.loadRequest(urlRequest as URLRequest)
//		}
//	}
//	// MARK: Cancel Auth Flow
//	
//	func cancelAuth() {
//		dismiss(animated: true, completion: nil)
//	}
//	
//
// 
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//// MARK: - TMDBAuthViewController: UIWebViewDelegate
//
//extension TMDBAuthViewController: UIWebViewDelegate {
//	
//	func webViewDidFinishLoad(_ webView: UIWebView) {
//		
//
//		
//		if webView.request!.url!.absoluteString == "\(TMDBClient.Constants.AuthorizationURL)\(requestToken!)/allow" {
//			
//			dismiss(animated: true) {
//				self.completionHandlerForView!(true, nil)
//			}
//		}
//	}
//}
