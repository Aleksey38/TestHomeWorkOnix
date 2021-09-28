//
//  ViewController.swift
//  TestOnixProject
//
//  Created by Aleksey on 26.09.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var stringUrl = "http://numbersapi.com/random/year"
    
    @IBOutlet weak var label: UILabel!
    @IBAction func button(_ sender: Any) {
        
        let url = URL(string: stringUrl)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var message = ""
            
            if let error = error {
                message = "Error \(error)"
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                message = "Response data string:\n \(dataString)"
            }
            self.dispatch(message: message)
        }
        task.resume()
    }

    @IBAction func buttonAla(_ sender: Any) {
        getMethod()
    }
    
    func getMethod() {
        AF.request(stringUrl, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { response in
            var message = " "
            
            if let error = response.error  {
                message = "Error \(error)"
            }
            if let data = response.data, let response = String(data: data, encoding: .utf8) {
                message = "Response data string:\n \(response)"
            }
            self.dispatch(message: message)
        }
    }
    
    func dispatch(message: String) {
        DispatchQueue.main.async {
            self.label.text = message
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.numberOfLines = 0
    }
    
}

