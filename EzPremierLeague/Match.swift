//
//  Match.swift
//  EzPremierLeague
//
//  Created by iOS Student on 3/20/17.
//  Copyright © 2017 tek4fun. All rights reserved.
//

import UIKit

class Match: NSObject {
    var date : String?
    var referee : String?
    var team1_Name : String?
    var team1_Score : Int?
    var team1_firstHalfScore : Int?
    var team2_Name : String?
    var team2_Score : Int?
    var team2_firstHalfScore : Int?

    init(information: [String : AnyObject]) {
        let date = information["when"] as! String?
        self.date = date!

        let referee = information["referee"] as! String?
        self.referee = referee!

        let team1 = information["team1"] as! [String : AnyObject]
        let team1_Name = team1["teamName"] as! String?
        self.team1_Name = team1_Name
        let team1_Score = team1["teamScore"] as! Int?
        self.team1_Score = team1_Score
        let team1_firstHalfScore = team1["firstHalfScore"] as! Int?
        self.team1_firstHalfScore = team1_firstHalfScore
        print(self.date!)
        print(self.team1_Name!)

        let team2 = information["team2"] as! [String : AnyObject]
        let team2_Name = team2["teamName"] as! String?
        self.team2_Name = team2_Name
        let team2_Score = team2["teamScore"] as! Int?
        self.team2_Score = team2_Score
        let team2_firstHalfScore = team2["firstHalfScore"] as! Int?
        self.team2_firstHalfScore = team2_firstHalfScore
        print(self.date!)
        print(team2)
    }
}
