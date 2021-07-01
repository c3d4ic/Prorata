//
//  Budget.swift
//  Prorata
//
//  Created by Cédric Chabaud on 11/06/2021.
//

import Foundation

struct Budget : Decodable {
    var userBudget: [UserBudget]
    var expenses: [Expense]
    var total: Double
    var title: String
    var picture: Picture
}

