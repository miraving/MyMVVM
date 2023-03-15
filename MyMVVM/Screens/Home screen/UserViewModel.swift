//
//  UserViewModel.swift
//  MyMVVM
//
//  Created by Vitalii on 13.01.2023.
//

import Foundation
import Alamofire
//import RxSwift
//import RxCocoa
import Combine

final class UserViewModel: BaseViewModel {
    @Published private(set) var model: User?
    
    func fetchData() {
        controllerState = .loading
        
        let url = "https://api.github.com/users/miraving"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: User.self, completionHandler: { [weak self] response in
                guard let self else { return }
                
                switch response.result {
                case .success(let model):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.model = model
                        self.controllerState = .showContent
                    }

                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self.controllerState = .showError(error.localizedDescription)
                }
            })
    }
}
