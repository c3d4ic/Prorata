//
//  Session.swift
//  Prorata
//
//  Created by Cédric Chabaud on 11/06/2021.
//

import Foundation

struct Session {
    var participants: [Participant]
    var sumParticipants: Double {
        return participants.map({$0.pay}).reduce(0, +)
    }
    var expenses: [Expense]
    var sumExpenses: Double {
        return expenses.map({$0.amount}).reduce(0, +)
    }
    var title: String
}
