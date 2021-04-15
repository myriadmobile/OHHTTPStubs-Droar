//
//  ViewController.swift
//  OHHTTPStubs-Droar
//
//  Created by Janglinator on 04/08/2021.
//  Copyright (c) 2021 Janglinator. All rights reserved.
//

import UIKit
import Alamofire
import OHHTTPStubs_Bushel

class Joke: Codable {
    var icon_url: String?
    var id: String?
    var url: String?
    var value: String?
}

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HTTPStubs.stubRequests { (request) -> Bool in
            return true
        } withStubResponse: { (request) -> HTTPStubsResponse in
            return HTTPStubsResponse(fileAtPath: OHPathForFile("joke.json", ViewController.self)!, statusCode: 200, headers: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startRequest(_ sender: Any) {
        label.text = nil
        
        Alamofire.request("https://api.chucknorris.io/jokes/random", method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).validate().responseJSON { [weak self] (response) in
            guard response.error == nil else {
                let alert = UIAlertController(title: "Error", message: response.error!.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            let joke = try? JSONDecoder().decode(Joke.self, from: response.data ?? Data())
            self?.label.text = joke?.value
        }
    }
}

