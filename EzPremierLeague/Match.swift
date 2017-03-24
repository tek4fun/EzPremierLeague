//
//  Match.swift
//  EzPremierLeague
//
//  Created by iOS Student on 3/20/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit

class Match: NSObject {
    var date : String!
    var time : String!
    var referee : String!
    var team1_Name : String!
    var team1_Score : String!
    var team1_img: UIImage!
    var team2_Name : String!
    var team2_Score : String!
    var team2_img: UIImage!

    //var result: String?
    let imgs = ["Bournemouth","Arsenal","Burnley","Chelsea","Crystal Palace","Everton","Hull City","Leicester City","Liverpool","Man City","Man United","Middlesbrough","Southampton","Stoke City","Sunderland","Swansea City","Tottenham","Watford","West Bromwich","West Ham"]
    init(information: [String : AnyObject]) {
        super.init()
        //Convert to UTC+2 to GMT+7
        let time = information["date_match"] as! String?
        let iTime = setTime(date: time!)
        self.date = iTime[0]
        let hour = convertTime(time: iTime[1])
        self.time = hour

        let team1 = information["home"] as! [String : AnyObject]

        let team1_Name = team1["team"] as! String
        self.team1_Name = team1_Name

        let team1_Score = team1["goals"]
        self.team1_Score = "\(team1_Score!)"

        let team1_img = UIImage(named: self.setImage(name: team1_Name))
        self.team1_img = team1_img

        let team2 = information["away"] as! [String : AnyObject]

        let team2_Name = team2["team"] as! String
        self.team2_Name = team2_Name

        let team2_Score = team2["goals"]
        self.team2_Score = "\(team2_Score!)"

        let team2_img = UIImage(named: self.setImage(name: team2_Name))
        self.team2_img = team2_img
    }

    private func setImage(name: String) -> String{
        for img in imgs {
            if name == img {
                return img
            }
        }
        return ""
    }

    private func setTime(date: String) -> [String]{
        let myTimeArr = date.components(separatedBy: "T")
        return myTimeArr
    }

    private func convertTime(time: String) -> String{
        let myTimeArr = time.components(separatedBy: ":")
        let iTime = Int(myTimeArr[0])! + 5
        let currentTime = "\(iTime):" + myTimeArr[1] + ":00"
        return currentTime
    }
}
