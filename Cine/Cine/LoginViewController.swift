//
//  LoginViewController.swift
//  Cine
//
//  Created by martin chibwe on 10/8/16.
//  Copyright © 2016 Martin Chibwe. All rights reserved.
//

import UIKit
//MARK: - LoginViweController: UIViverController
class LoginViewController: UIViewController {
	
	//MARK: Properties
	
	var appDelegate: AppDelegate!
	
	
	@IBOutlet weak var usernameTextField: UITextField!
	
	@IBOutlet weak var passwordTextField: UITextField!
	
	@IBOutlet weak var loginButton: UIButton!
	
	@IBOutlet weak var debugLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		appDelegate = UIApplication.shared.delegate as! AppDelegate
//		getGuestSessionId()
//		getRequestToken()
//		getGuestSessionId()
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		
	}
	
	
	@IBAction func loginPressed(_ sender: AnyObject) {
		
		if (usernameTextField.text!.isEmpty) || passwordTextField.text!.isEmpty {
			debugLabel.text = "Username or Password Empty"
			
		}else{
			
			setUIEnabled(enabled: false)
			/*
			
			Steps for Authentication...
			https://www.themoviedb.org/documentation/api/sessions
			
			Step 1: Create a request token
			
			
			Step 2: Ask the user for permission via the API ("login")
			Step 3: Create a session ID
			
			Extra Steps...
			Step 4: Get the user id ;)
			Step 5: Go to the next view!
			*/
			getRequestToken()
			
			
		}
		
	}
	
	
	func getRequestToken()  {
		
		/*Set the parameters */
		let methodParameters = [
			Constants.TMDBParameterKeys.ApiKey:
				Constants.TMDBParameterValues.ApiKey as AnyObject
			
		]
		
		/*2/3 Build the URL, Configure the request*/
		let request = NSURLRequest(url: appDelegate.tmdbURLFromParameters(parameters: methodParameters, withPathExtension: "/authentication/token/new") as URL)
		
		print("Request \(request)")
		
		/* 4. Make the request */
		
		
		let task = appDelegate.sharedSession.dataTask(with: request as URLRequest){ (data,response,error) in
			
			func displayError(error: String){
				
				print(error)
				performUIUpdatesOnMain {
					self.debugLabel.text = "Login Failed (Request Token)"
					
				}
				
			}
			
			/*Guard: was there an error ?*/
			guard (error == nil) else {
				displayError(error: "There was an error with your request: \(error)")
				return
			}
			
			
			/*Guard: Did we get a sucessful 2xx response?*/
			guard let statusCode = (response as? HTTPURLResponse)? .statusCode , statusCode >= 200 && statusCode <= 299 else{
				
				displayError(error: "Your request returned a status code other than 2xx!")
				return
				
			}
			
			/*Guard: Was there any data returned?*/
			guard let data = data else {
				displayError(error: "No data was returned by the request")
				return
			}
			
			
			/* 5 Parse the data!*/
			let parsedResult: AnyObject!
			do {
				 parsedResult = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as AnyObject
		
				
				
			} catch {
				displayError(error: "Could not parse the data as JSON: '\(data)'")
				return
			}
			
			
			/* GUARD: Did TheMovieDB return an error? */
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
				
				displayError(error: "TheMOvieDB returned an error. See the \(Constants.TMDBResponseKeys.StatusCode)  in \(parsedResult)")
				return
				
			}
			
			/*GUARD: Is the "request_token" key in parsedResult?*/
			guard let requestToken = parsedResult[Constants.TMDBResponseKeys.RequestToken] as? String else {
				displayError(error: "Cannot find key \(Constants.TMDBResponseKeys.RequestToken) in \(parsedResult)")
				return
				
			}
			
			/*Use the data!*/
			self.appDelegate.requestToken = requestToken
			self.loginWithToken(requestToken: self.appDelegate.requestToken!)
//			self.getGuestSessionId(requestToken: self.appDelegate.requestToken!)
			
			print("RequestTokenn \(requestToken)")
		}
		/*7 start the request*/
		task.resume()
		

	}
	
	
	
	func loginWithToken(requestToken: String)  {
		
		/* 1 Set the parameters */
		let methodParameters : [String: String] = [
			Constants.TMDBParameterKeys.ApiKey:
			Constants.TMDBParameterValues.ApiKey,
			Constants.TMDBParameterKeys.Username: usernameTextField.text!,
			Constants.TMDBParameterKeys.Password: passwordTextField.text!,
			Constants.TMDBResponseKeys.RequestToken: requestToken
			
		]
		
		print("Methodparameters \(methodParameters)")
		
		
		/*2/3 Build the URL, Configure the request*/
		let request = NSURLRequest(url: appDelegate.tmdbURLFromParameters(parameters: methodParameters as [String : AnyObject], withPathExtension: "/authentication/token/validate_with_login") as URL)
		/*4 Make the request */
		let task = appDelegate.sharedSession.dataTask(with: request as URLRequest){(data, response, error) in
			
			func displayError(error: String){
				
				print(error)
				performUIUpdatesOnMain {
					self.debugLabel.text = "Login Failed (Request Token)"
					
				}
				
			}
			
			/*Guard: were there any error ?*/
			guard(error == nil) else{
				displayError(error: "There was an error with your request \(error)")
				return
			}
			
			/*Guard: Did we get a sucessful 2xx response*/
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else{
				
				displayError(error: "Your request returned a status code other than 2xx! in Login")
				
				return
			}
			
			
			/*Guard: Was ther any data returned */
			guard let data = data else{
				displayError(error: "No data was returned by the request")
				
				return
			}
			
			/*Parse the data!*/
			let parsedResult : AnyObject!
			
			do{
				parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
				
			}catch {
				displayError(error: "Could not parse the data as JSON: \(data)")
				return
			}
			
			
			/*Guard: Did TheMovieDataBase return an error */
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
				displayError(error: "TheMovieDB returned an error. See The \(Constants.TMDBResponseKeys.StatusCode) in \(parsedResult)")
				
				return
			}
			
			
			
//			print(" parsedResult = \(parsedResult)")
			/*Guard: Is the Guest Session ID in parsedResults*/
//			guard let userValidRequest = parsedResult[Constants.TMDBResponseKeys.RequestToken] as? String else {
//				displayError(error: "Cannot find key \(Constants.TMDBResponseKeys.RequestToken) in \(parsedResult)")
//				return
//				
//			}
			
			
			/*Use the data!*/
			
//			print("ValidedID \(userValidRequest )")
			self.getSessionID(requestToken: self.appDelegate.requestToken!)
			
			
			
		}//end task
		task.resume()

		
	}
	
	
	func getSessionID(requestToken: String)  {
		
		
		
		/*Parameters*/
		let methodParameters = [
			Constants.TMDBParameterKeys.ApiKey : Constants.TMDBParameterValues.ApiKey,
			Constants.TMDBParameterKeys.RequestToken: requestToken
		]
		
		
		/*Build web */
		
		let request = NSURLRequest(url: appDelegate.tmdbURLFromParameters(parameters: methodParameters as [String : AnyObject], withPathExtension: "/authentication/session/new") as URL)
		
		print("reqSessionID \(request)")
		let task = appDelegate.sharedSession.dataTask(with: request as URLRequest){(data, response, error) in
			
			func displayError(error: String){
				
				print(error)
				performUIUpdatesOnMain {
					self.debugLabel.text = "Login Failed (Request Token)"
					
				}
				
			}
			
			/*Guard: were there any error ?*/
			guard(error == nil) else{
				displayError(error: "There was an error with your request \(error)")
				return
			}
			
			/*Guard: Did we get a sucessful 2xx response*/
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else{
				
				displayError(error: "Your request returned a status code other than 2xx! in Login")
				
				return
			}
			
			/*Guard: Was ther any data returned */
			guard let data = data else{
				displayError(error: "No data was returned by the request")
				
				return
			}
			
			/*Parse the data!*/
			let parsedResult : AnyObject!
			
			do{
				parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
				
			}catch {
				displayError(error: "Could not parse the data as JSON: \(data)")
				return
			}
			
			
			/*Guard: Did TheMovieDataBase return an error */
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
				displayError(error: "TheMovieDB returned an error. See The \(Constants.TMDBResponseKeys.StatusCode) in \(parsedResult)")
				
				return
			}
			print(" parsedResultSessionID = \(parsedResult)")
			
			/*Guard: Is the Guest Session ID in parsedResults*/
			guard let userSessionID = parsedResult[Constants.TMDBResponseKeys.SessionID] as? String else {
				displayError(error: "Cannot find key \(Constants.TMDBResponseKeys.SessionID) in \(parsedResult)")
				return
				
			}
			
			
			self.appDelegate.sessionID = userSessionID
			self.getUserID(sessionID: userSessionID)
			print("UserSessionID \(userSessionID)")
			
			
			
		
		
		
		}//end task
		task.resume()

	}
	
	
	func getUserID(sessionID: String) {
		
		
		let methodParameters = [
			Constants.TMDBParameterKeys.ApiKey: Constants.TMDBParameterValues.ApiKey,
			Constants.TMDBParameterKeys.SessionID: sessionID

		]
		
		let request = NSURLRequest(url: appDelegate.tmdbURLFromParameters(parameters: methodParameters as [String : AnyObject], withPathExtension: "/account") as URL)
		
		
		let task = appDelegate.sharedSession.dataTask(with: request as URLRequest){(data, response,error) in
			
			func displayError(error: String){
				
				print(error)
				performUIUpdatesOnMain {
					self.debugLabel.text = "Login Failed (Request Token)"
					
				}
				
			}
			
			/*Guard: were there any error ?*/
			guard(error == nil) else{
				displayError(error: "There was an error with your request \(error)")
				return
			}
			
			/*Guard: Did we get a sucessful 2xx response*/
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else{
				
				displayError(error: "Your request returned a status code other than 2xx! in UserId")
				
				return
			}
			
			/*Guard: Was ther any data returned */
			guard let data = data else{
				displayError(error: "No data was returned by the request")
				
				return
			}
			
			/*Parse the data!*/
			let parsedResult : AnyObject!
			
			do{
				parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
				
			}catch {
				displayError(error: "Could not parse the data as JSON: \(data)")
				return
			}
			
			
			/*Guard: Did TheMovieDataBase return an error */
			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
				displayError(error: "TheMovieDB returned an error. See The \(Constants.TMDBResponseKeys.StatusCode) in \(parsedResult)")
				
				return
			}
			print(" parsedResultUerID = \(parsedResult)")
			
			/*Guard: Is the Guest Session ID in parsedResults*/
			guard let userID = parsedResult[Constants.TMDBResponseKeys.UserID] as? Int else {
				displayError(error: "Cannot find key \(Constants.TMDBResponseKeys.UserID) in \(parsedResult)")
				return
				
			}
			
			print("UserID \(userID)")
			self.appDelegate.userID = userID

				}
		
		task.resume()
	}
	
	func completeLogin() {
		performUIUpdatesOnMain {
			self.debugLabel.text = ""
			self.setUIEnabled(enabled: true)
			let controller = self.storyboard!.instantiateViewController(withIdentifier: "MainViewController") as! UITabBarController
			self.present(controller, animated: true, completion: nil)
		}
	}
	
	
	
	
//	func getGuestSession(requestToken: String)  {
//
//		/* 1 Set the parameters */
//		let methodParameters = [
//			Constants.TMDBParameterKeys.ApiKey:
//				Constants.TMDBParameterValues.ApiKey as AnyObject,
//			Constants.TMDBResponseKeys.RequestToken: requestToken as AnyObject
//			
//		]
//		
//		
//		/*2/3 Build the URL, Configure the request*/
//		let request = NSURLRequest(url: appDelegate.tmdbURLFromParameters(parameters: methodParameters, withPathExtension: "/authentication/guest_session/new") as URL)
//		/*4 Make the request */
//		let task = appDelegate.sharedSession.dataTask(with: request as URLRequest){(data, response, error) in
//			
//			func displayError(error: String){
//				
//				print(error)
//				performUIUpdatesOnMain {
//					self.debugLabel.text = "Login Failed (Request Token)"
//					
//				}
//				
//			}
//			
//			/*Guard: were there any error ?*/
//			guard(error == nil) else{
//				displayError(error: "There was an error with your request \(error)")
//				return
//			}
//			
//			/*Guard: Did we get a sucessful 2xx response*/
//			guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else{
//				
//				displayError(error: "Your request returned a status code other than 2xx!")
//				
//				return
//			}
//			
//			
//			/*Guard: Was ther any data returned */
//			guard let data = data else{
//				displayError(error: "No data was returned by the request")
//				
//				return
//			}
//			
//			/*Parse the data!*/
//			let parsedResult : AnyObject!
//			
//			do{
//				parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
//				
//			}catch {
//				displayError(error: "Could not parse the data as JSON: \(data)")
//				return
//			}
//			
//			
//			/*Guard: Did TheMovieDataBase return an error */
//			if let _ = parsedResult[Constants.TMDBResponseKeys.StatusCode] as? Int {
//				displayError(error: "TheMovieDB returned an error. See The \(Constants.TMDBResponseKeys.StatusCode) in \(parsedResult)")
//				
//				return
//			}
//			
//			
//			/*Guard: Is the Guest Session ID in parsedResults*/
//			guard let guestSessionID = parsedResult[Constants.TMDBResponseKeys.GuestSessionID] as? String else {
//				displayError(error: "Cannot find key \(Constants.TMDBResponseKeys.GuestSessionID) in \(parsedResult)")
//				return
//				
//			}
//			
//			
//			/*Use the data!*/
//			//			print("guestSessionID  \(guestSessionID)")
//			
//			
//			
//			
//		}//end task
//		task.resume()
//	
	
	
//	}

	
}


extension LoginViewController : UITextFieldDelegate{
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func setUIEnabled(enabled: Bool) {
		usernameTextField.isEnabled = enabled
		passwordTextField.isEnabled = enabled
		loginButton.isEnabled = enabled
		debugLabel.text = ""
		debugLabel.isEnabled = enabled
		
		// adjust login button alpha
		//		if enabled {
		//			loginButton.alpha = 1.0
		//		} else {
		//			loginButton.alpha = 0.5
		//		}
	}
	
	private func configureUI() {
		
		// configure background gradient
		let backgroundGradient = CAGradientLayer()
		backgroundGradient.colors = [Constants.UI.LoginColorTop, Constants.UI.LoginColorBottom]
		backgroundGradient.locations = [0.0, 1.0]
		backgroundGradient.frame = view.frame
		view.layer.insertSublayer(backgroundGradient, at: 0)
		
		configureTextField(textField: usernameTextField)
		configureTextField(textField: passwordTextField)
	}
	
	private func configureTextField(textField: UITextField) {
		let textFieldPaddingViewFrame = CGRect(x: 0.0, y: 0.0, width: 13.0, height: 0.0)
		let textFieldPaddingView = UIView(frame: textFieldPaddingViewFrame)
		textField.leftView = textFieldPaddingView
		textField.leftViewMode = .always
		textField.backgroundColor = Constants.UI.GreyColor
		textField.textColor = Constants.UI.BlueColor
		textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.white])
		textField.tintColor = Constants.UI.BlueColor
		textField.delegate = self
	}
}

