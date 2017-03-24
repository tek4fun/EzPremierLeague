//
//  CalendarVC.swift
//  EzPremierLeague
//
//  Created by iOS Student on 3/24/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit
let baseUrl : String! = "https://sportsop-soccer-sports-open-data-v1.p.mashape.com/v1/leagues/"
class CalendarVC: UITableViewController {
    var informations = [Match]()
    override func viewDidLoad() {
        super.viewDidLoad()
        gotData()

    }
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
                self.tableView.reloadData()
            }
        }

    }
    //Mark: Get Data Request
    func getData(completion: @escaping (_ any: AnyObject) -> Void) {
        var urlRequest = URLRequest(url: URL(string: baseUrl+"premier-league/seasons/16-17/rounds/round-1/matches")!)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.informations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailMatchCell
        let match: Match = self.informations[indexPath.row]
        cell.lbl_Team1.text = match.team1_Name
        cell.lbl_Team2.text = match.team2_Name
        cell.lbl_Team1Score.text = match.team1_Score
        cell.lbl_Team2Score.text = match.team2_Score
        cell.img_Team1.image = match.team1_img
        cell.img_Team2.image = match.team2_img
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.gray
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let match: Match = self.informations[section]
        return match.date
    }


}
