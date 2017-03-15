//
//  ViewController.swift
//  EzPremierLeague
//
//  Created by iOS Student on 3/13/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit
let baseUrl : String! = "https://heisenbug-premier-league-live-scores-v1.p.mashape.com/api/premierleague?matchday=1&season=2016-17"
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    //Mark: Get Data Request
    func getData() {
        var urlRequest = URLRequest(url: URL(string: baseUrl)!)
        urlRequest.setValue("khH3Nrssr5mshuAmXyBC241TJS7lp1ctzcFjsnyRrlumX2dl0c", forHTTPHeaderField: "X-Mashape-Key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"
        let getDataSession = URLSession.shared

        getDataSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {

                if let responseHTTP = response as? HTTPURLResponse{
                    if responseHTTP.statusCode == 200 {
                        guard let information = data else { return}
                        do {
                            let result = try JSONSerialization.jsonObject(with: information, options: .allowFragments) as! NSDictionary

                            if let arrayResult = result.value(forKey: "matches"){

                                for infoDict in arrayResult as! [NSDictionary]{
                                    print(infoDict.value(forKey: "referee")!)
                                    print(infoDict.value(forKey: "team1")!)
                                }
                            }
                        }catch let error {
                            print(error.localizedDescription)
                        }
                    } else {
                        print(responseHTTP.statusCode)
                    }
                }
            }
        }.resume()

        //        let configureSession = URLSessionConfiguration.default
        //        configureSession.httpAdditionalHeaders = ["X-Mashape-Key" : "khH3Nrssr5mshuAmXyBC241TJS7lp1ctzcFjsnyRrlumX2dl0c", "Accept" : "application/json"]
        //
        //        let getDataSession = URLSession(configuration: configureSession)
        //        getDataSession.uploadTask(with: urlRequest as URLRequest, from: nil) { (data, response, error) in
        //            print(data)
        //            if let error = error {
        //                print(error.localizedDescription)
        //            } else {
        //                if let responseHTTP = response as? HTTPURLResponse{
        //                    if responseHTTP.statusCode == 200 {
        //                        print(data)
        //                    }else {
        //                        print(responseHTTP.statusCode)
        //                    }
        //            }
        //            }
        //        }.resume()
        //    }
    }
}



