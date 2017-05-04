//
//  CalendarVC.swift
//  EzPremierLeague
//
//  Created by iOS Student on 3/24/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit
//let baseUrl : String! = "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/"

class CalendarVC: UITableViewController {
    
    var informations = [Match]()
    var matchByDate = NSMutableDictionary()
    var arrayKey = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gotData()
     
    }
    //Mark: Handle Data
    func gotData() {
        getData { (dataResult) in
            if let arrayResult = dataResult.value(forKey: "matches")
            {
                for infoDict in arrayResult as! [AnyObject]
                {
                    if let infoDict = infoDict as? [String : AnyObject]{
                        self.informations.append(Match(information: infoDict))
                    }
                }
            }
            DispatchQueue.main.async {
                for match in self.informations {
                    var arrayForDate: NSMutableArray!
                    let key = match.date

                    if self.matchByDate.value(forKey: match.date) != nil {
                        arrayForDate = self.matchByDate.value(forKey: key!) as! NSMutableArray
                        arrayForDate.add(match)
                        self.matchByDate.setValue(arrayForDate, forKey: key!)
                    }
                    else{
                        arrayForDate = NSMutableArray(object: match)
                        self.matchByDate.setValue(arrayForDate, forKey: key!)
                    }
                }
                
                self.arrayKey = self.matchByDate.allKeys as! [String] as NSArray!
                self.arrayKey = self.arrayKey.sortedArray(using: #selector(NSNumber.compare(_:))) as NSArray!
                self.tableView.reloadData()
            }
        }

    }
    
    
    //Mark: Get Data Request
    func getData(completion: @escaping (_ any: AnyObject) -> Void) {
        var urlRequest = URLRequest(url: URL(string: "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/premier-league/seasons/16-17/rounds/round-1/matches")!)
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
                            let result = try JSONSerialization.jsonObject(with: information, options: .allowFragments) as AnyObject

                            if let dataResult = result.value(forKey: "data") as AnyObject!{
                                completion(dataResult)
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
    }

    //Mark: Config TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayKey.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = arrayKey[section]
        let sectionMatchs = matchByDate[sectionTitle as! String] as! NSArray
        return sectionMatchs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailMatchCell
        let sectionTitle = arrayKey[indexPath.section]
        let sectionMatchs = matchByDate[sectionTitle as! String] as! NSArray

        let match: Match = sectionMatchs[indexPath.row] as! Match
        cell.lbl_Team1.text = match.team1_Name
        cell.lbl_Team2.text = match.team2_Name
        cell.lbl_Team1Score.text = match.team1_Score
        cell.lbl_Team2Score.text = match.team2_Score
        cell.img_Team1.image = match.team1_img
        cell.img_Team2.image = match.team2_img
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.blue
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayKey[section] as? String
    }
    

    

}
