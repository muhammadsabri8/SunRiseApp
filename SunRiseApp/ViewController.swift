//
//  ViewController.swift
//  SunRiseApp
//
//  Created by Mac on 9/4/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var CityTF: UITextField!
    @IBOutlet weak var SunRiseLa: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func SunRiseBu(_ sender: UIButton) {
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20\(CityTF.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        
        LoadURL(url: url)
    }

    func LoadURL(url : String) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON
            { respose in
                switch respose.result {
                case .failure(let Error):
                    print(Error)
                case .success(let value):
                    let json = JSON(value)
                    
                    let sunrise = json["query"]["results"]["channel"]["astronomy"]["sunrise"]
                    
                    print(sunrise)
                    
                   self.SunRiseLa.text = "Sun Rise at : \(sunrise)"
                    
                }
                
        }

    
        
    }
}

