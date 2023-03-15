//
//  BaseViewModel.swift
//  MyMVVM
//
//  Created by Vitalii on 15.12.2022.
//

import Foundation
import Combine

class BaseViewModel {
    @Published var controllerState: ControllerState = .loading
}
