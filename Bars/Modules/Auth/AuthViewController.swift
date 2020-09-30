//
//  AuthViewController.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SVProgressHUD

class AuthViewController: UIViewController {
    
    private enum Constants {
        // TODO: - Adjust constants
        static var titleWidth: CGFloat = 280
        static var loginWidth: CGFloat = 200
        static var titleCenterY: CGFloat = -100
    }
    
    var viewModel: AuthViewModelProtocol?
    var rxdisposableBag = DisposeBag()
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = label.font.withSize(22)
        label.text = NSLocalizedString("AuthViewModule.title", comment: "")
        return label
    }()
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.black
        textField.borderStyle = .roundedRect
       // textField.text = "raz"
        textField.delegate = self
        textField.returnKeyType = .next
        
        textField.placeholder = NSLocalizedString("AuthViewModule.login.placeholder", comment: "")
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.black
        textField.borderStyle = .roundedRect
     //   textField.text = "gabitus"
        textField.delegate = self
        textField.returnKeyType = .send
        textField.placeholder = NSLocalizedString("AuthViewModule.password.placeholder", comment: "")
        return textField
    }()
    private lazy var buttonEntry: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("AuthViewModule.button.title", comment: ""), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(buttonEntry)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.centerY.equalTo(self.view).offset( Constants.titleCenterY)
            $0.width.equalTo(Constants.titleWidth)
        }
        
        loginTextField.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.width.equalTo(Constants.loginWidth)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(loginTextField.snp.bottom).offset(16)
            $0.width.equalTo(Constants.loginWidth)
        }
        
        buttonEntry.snp.makeConstraints {
            $0.centerX.equalTo(self.view)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(24)
            $0.width.equalTo(Constants.loginWidth)
        }
        
        buttonEntry.rx.tap
            .subscribe(onNext: { [weak self] _ in
                SVProgressHUD.show()
                self?.goAuth()
            })
            .disposed(by: rxdisposableBag)
        
        viewModel?.authError
            .asObservable()
            .subscribe(onNext: { [weak self] error in
                if !error.isEmpty {
                    self?.showAlert(error)
                }
            })
            .disposed(by: rxdisposableBag)

    }
    
    func goAuth() {
        guard let login = self.loginTextField.text, let password = self.passwordTextField.text else { return }
        self.viewModel?.tapButtonEntry(login: login, password: password)
    }
    
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        if textField.returnKeyType == .next {
            passwordTextField.becomeFirstResponder()
        }
        if textField.returnKeyType == .send {
            view.endEditing(true)
            goAuth()
        }
        
        return true
    }
}
