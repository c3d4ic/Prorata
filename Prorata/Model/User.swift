//
//  User.swift
//  Prorata
//
//  Created by Cédric Chabaud on 11/06/2021.
//

import Foundation

struct User {
    var email: String
    var name: Name
    var picture: Picture
}

struct Picture {
    var large: String
    var medium: String
    var thumbnail: String
}

struct Name: Decodable {
    var title: String
    var first: String
    var last: String
}
