//
//  BaseViewModel.swift
//  MyMVVM
//
//  Created by Vitalii on 15.12.2022.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    var controllerState = PublishSubject<ControllerState>()
}

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
