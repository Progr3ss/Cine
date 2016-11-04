//
//  BlackBoxGDC.swift
//  Cine
//
//  Created by martin chibwe on 10/6/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: @escaping () -> Void) {
	DispatchQueue.main.async {
		updates()
	}

}
