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
        resultLabel.textColor = .black
    }
    
    private func binding() {
        viewModel.model
            .subscribe { [weak self] user in
                self?.updateUI(model: user)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateUI(model: User) {
        resultLabel.text = String(describing: model)
    }
}
