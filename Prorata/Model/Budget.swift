//
//  Budget.swift
//  Prorata
//
//  Created by Cédric Chabaud on 11/06/2021.
//

import Foundation

struct Budget {
    var userBudget: [UserBudget]
    var expenses: [Expense]
    var total: Double
//     {
//        return expenses.reduce(function(a,b){return a.pay + b.pay}, +)
//    }
    var title: String
    var picture: Picture
}
