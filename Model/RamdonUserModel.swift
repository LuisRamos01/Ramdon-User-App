//
//  RamdonUserModel.swift
//  RamdonUserApp
//
//  Created by Luis Eduardo Ramos on 21/05/2024.
//

import Foundation

struct RamdomUserResponse: Codable {
    
    let results: [User]
}

struct User: Codable {
    let name: Name
    let email: String
    var login: Login
    let picture: Picture
}

struct Login: Codable {
    var password: String
}

struct Name: Codable {
    
    let  first: String
    let last: String
}

struct Picture: Codable {
    
    let large: String
    let thumbnail: String
}

