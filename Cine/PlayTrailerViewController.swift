//
//  PlayTrailerViewController.swift
//  Cine
//
//  Created by martin chibwe on 12/9/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit

class PlayTrailerViewController: UIViewController {

	@IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		var YoutubeVideoLink:String = "http://www.youtube.com/embed/OsINvu5FYKg"
		let width = 300
		let height = 200
		let frame = 30
		let Code:NSString = "<iframe width=\(width) height=\(height) src=\(YoutubeVideoLink) frameborder=\(frame) allowfullscreen></iframe>" as NSString
		
		self.webView.loadHTMLString(Code as String, baseURL: nil)

        // Do any additional setup after loading the view.
		
	
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	
    


}



//extension PlayTrailerViewController : UIWebViewDelegate{
//	func evaluate(script: String, completion: (result: AnyObject?, error: NSError?) -> Void) {
//		var finished = false
//		
//		evaluateJavaScript(script) { (result, error) in
//			if error == nil {
//				if result != nil {
//					completion(result: result, error: nil)
//				}
//			} else {
//				completion(result: nil, error: error)
//			}
//			finished = true
//		}
//		
//		while !finished {
//			RunLoop.current().run(mode: .defaultRunLoopMode, before: Date.distantFuture)
//		}
//	}
//}
