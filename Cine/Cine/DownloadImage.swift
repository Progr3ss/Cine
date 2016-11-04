//
//  DownloadImage.swift
//  Cine
//
//  Created by martin chibwe on 10/17/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
	
	func loadImage(url: URL) -> URLSessionDownloadTask {
		
		let session = URLSession.shared
		// 1
		let downloadTask = session.downloadTask(with: url,
			// 2
			completionHandler: { [weak self] url, response, error in
				
				if error == nil, let url = url,
					
					let data = try? Data(contentsOf: url),
					
					// 3
					// 4
					let image = UIImage(data: data) {
					
					DispatchQueue.main.async {
						if let strongSelf = self {
							strongSelf.image = image
						}
					} }
			})
		// 5
		
		downloadTask.resume()
		
		print("Download \(downloadTask)")
		return downloadTask
	}
}
