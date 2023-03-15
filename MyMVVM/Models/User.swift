//
//  User.swift
//  MyMVVM
//
//  Created by Vitalii on 15.03.2023.
//

import Foundation

struct User: Decodable {
    var id: Int
    var avatar_url: URL?
    var name: String?
    var type: String?
    var bio: String?
    var blog: String?
    var login: String?
    var url: URL?
}
