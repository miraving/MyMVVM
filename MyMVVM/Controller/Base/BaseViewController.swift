//
//  BaseViewController.swift
//  MyMVVM
//
//  Created by Vitalii on 15.12.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum ControllerState {
    case loading, showContent, showError(String?)
}

class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
    private var errorLabel = UILabel(frame: .zero)
    private var activityView = UIActivityIndicatorView(style: .large)
    
    var disposeBag = DisposeBag()
    var viewModel: ViewModel!
    
    
    // MARK: -
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainInitialization()
        binding()
    }
    
    private func mainInitialization() {
        view.backgroundColor = .white
        
        view.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityView.color = .red
        
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.greaterThanOrEqualTo(15)
        }
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
    }

    private func binding() {
        viewModel.controllerState
            .subscribe(onNext: { [weak self] state in
                self?.updateState(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateState(state: ControllerState) {
        errorLabel.isHidden = true
        activityView.stopAnimating()
        switch state {
        case .loading:
            view.bringSubviewToFront(activityView)
            activityView.startAnimating()
            
        case .showContent:
            activityView.stopAnimating()
            
        case .showError(let message):
            activityView.stopAnimating()
            errorLabel.isHidden = false
            errorLabel.text = message
            view.bringSubviewToFront(errorLabel)
        }
    }
}

