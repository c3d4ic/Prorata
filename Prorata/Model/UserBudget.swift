//
//  UserBudget.swift
//  Prorata
//
//  Created by Cédric Chabaud on 11/06/2021.
//

import Foundation

struct UserBudget : Decodable {
    var user: User
    var pay: Double
}
