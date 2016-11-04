//
//  SignupWebViewViewController.swift
//  Cine
//
//  Created by martin chibwe on 10/10/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class SignupWebViewViewController: UIViewController {

	@IBOutlet weak var webView: UIWebView!
	
//	let url = NSURL (string: "https://www.themoviedb.org/account/signup")
//	let urlRequest = URLRequest(url: url)
//	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let url = NSURL (string: "https://www.themoviedb.org/account/signup")
		let urlRequest = URLRequest(url: url as! URL)
		
		performUIUpdatesOnMain{
			self.webView.loadRequest(urlRequest)
			
		}
		
		

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
