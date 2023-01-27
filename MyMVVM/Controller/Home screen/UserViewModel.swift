//
//  UserViewModel.swift
//  MyMVVM
//
//  Created by Vitalii on 13.01.2023.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class UserViewModel: BaseViewModel {
    var model = PublishSubject<User>()
    
    func fetchData() {
        controllerState.onNext(.loading)
        
        let url = "https://api.github.com/users/miraving"
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: User.self, completionHandler: { [weak self] response in
                switch response.result {
                case .success(let model):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self?.model.onNext(model)
                        self?.controllerState.onNext(.showContent)
                    }

                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.controllerState.onNext(.showError(error.localizedDescription))
                }
            })
    }
}
