//
//  UserViewController.swift
//  MyMVVM
//
//  Created by Vitalii on 13.01.2023.
//

import UIKit

final class UserViewController: BaseViewController<UserViewModel> {
    
    private var resultLabel = UILabel(frame: .zero)
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainInitialization()
        binding()
        
        // call fetch when needed or made some trigger for that
        viewModel.fetchData()
    }
    
    private func mainInitialization() {
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.greaterThanOrEqualTo(8)
        }
        resultLabel.numberOfLines = 0
    }
    
    private func binding() {
        viewModel.$model
            .sink { [weak self] model in
                self?.updateUI(model: model)
            }
            .store(in: &subscriptions)
    }
    
    private func updateUI(model: User?) {
        guard let model else {
            resultLabel.text = ""
            return
        }
        var result = ""
        if let value = model.name {
            result.append("name: \(value)")
        }
        if let value = model.login {
            result.append("\n")
            result.append("nickname: \(value)")
        }
        if let value = model.url {
            result.append("\n")
            result.append("url: \(value)")
        }
        resultLabel.text = result
    }
}
