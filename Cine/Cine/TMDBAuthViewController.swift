////
////  TMDBAuthViewController.swift
////  Cine
////
////  Created by martin chibwe on 10/8/16.
////  Copyright © 2016 Martin Chibwe. All rights reserved.
////
//
import UIKit

// MARK: - TMDBAuthViewController: UIViewController

class TMDBAuthViewController: UIViewController {
	
	// MARK: Properties
	
	var urlRequest: URLRequest? = nil
	var requestToken: String? = nil
	var completionHandlerForView: ((_ success: Bool, _ errorString: String?) -> Void)? = nil
	
	// MARK: Outlets
	
	@IBOutlet weak var webView: UIWebView!
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		webView.delegate = self
		
		navigationItem.title = "TheMovieDB Auth"
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAuth))
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let urlRequest = urlRequest {
			webView.loadRequest(urlRequest)
		}
	}
	
	// MARK: Cancel Auth Flow
	
	func cancelAuth() {
		dismiss(animated: true, completion: nil)
	}
}

// MARK: - TMDBAuthViewController: UIWebViewDelegate

extension TMDBAuthViewController: UIWebViewDelegate {
	
	func webViewDidFinishLoad(_ webView: UIWebView) {
		
		// if user has to login, this will redirect them back to the authorization url
		if webView.request!.url!.absoluteString.contains(TMDBClient.Constants.AccountURL) {
			if let urlRequest = urlRequest {
				webView.loadRequest(urlRequest)
			}
		}
		
		if webView.request!.url!.absoluteString == "\(TMDBClient.Constants.AuthorizationURL)\(requestToken!)/allow" {
			
			dismiss(animated: true) {
				self.completionHandlerForView!(true, nil)
			}
		}
	}
}
