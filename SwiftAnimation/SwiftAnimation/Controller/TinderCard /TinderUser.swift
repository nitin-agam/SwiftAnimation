//
//  TinderUser.swift
//  SwiftAnimation
//
//  Created by Nitin A on 01/02/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

struct TinderUser {
    
    let name: String
    let country: String
    let imageName: String
    let age: Int
    let userId: Int
    
    
    static func users() -> [TinderUser] {
        return [
            TinderUser(name: "Julie Charlie", country: "Brazil", imageName: "julie_charile", age: 31, userId: 1),
            TinderUser(name: "Alex Murphy", country: "USA", imageName: "alex_murphy", age: 28, userId: 2),
            TinderUser(name: "Annie Spark", country: "Argentina", imageName: "annie_spark", age: 21, userId: 3),
            TinderUser(name: "Alexender", country: "Mauritius", imageName: "alexender", age: 23, userId: 4),
            TinderUser(name: "Connon Bolt", country: "Mexico", imageName: "connon_bolt", age: 22, userId: 5),
            TinderUser(name: "Daniel Richard", country: "USA", imageName: "daniel_richard", age: 27, userId: 6),
            TinderUser(name: "Emily Kohn", country: "Philippines", imageName: "emily_kohn", age: 30, userId: 7),
            TinderUser(name: "Karry Martin", country: "Russia", imageName: "karry_martin", age: 33, userId: 8),
            TinderUser(name: "Robert Martin", country: "Canada", imageName: "robert_martin", age: 28, userId: 9),
            TinderUser(name: "Somanth Smith", country: "Belgium", imageName: "somanth_smith", age: 26, userId: 10),
            TinderUser(name: "Sona Ibrahim", country: "Singapore", imageName: "sona_ibrahim", age: 25, userId: 11),
            TinderUser(name: "Terena Vini", country: "Mongolia", imageName: "terena_vini", age: 22, userId: 12)
        ]
    }
}
