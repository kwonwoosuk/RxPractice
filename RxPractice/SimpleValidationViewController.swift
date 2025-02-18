//
//  SimpleValidationViewController.swift
//  RxPractice
//
//  Created by 권우석 on 2/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SimpleValidationViewController: ViewController {
    
    private let usernameLabel = UILabel()
    private let usernameTextField = UITextField()
    private let usernameValidLabel = UILabel()
    
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordValidLabel = UILabel()
    
    private let signUpButton = UIButton()
    
    private let minimalUsernameLength = 4
    private let minimalPasswordLength = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .withUnretained(self)
            .map { owner, value in
                value.count >= owner.minimalUsernameLength
            }
            .share(replay: 1) // share(replay:)의 의미는?
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .withUnretained(self)
            .map { owner, value in
                value.count >= owner.minimalPasswordLength
            }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.showAlert(message: "들어온나!") {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    func setup() {
        [usernameLabel, usernameTextField, usernameValidLabel, passwordLabel, passwordTextField, passwordValidLabel, signUpButton].forEach { view.addSubview($0) }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(21)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        usernameValidLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValidLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        
        
        view.backgroundColor = .white
        navigationItem.title = "Simple Validation"
        
        usernameLabel.text = "Username"
        usernameLabel.font = .systemFont(ofSize: 16)
        usernameTextField.borderStyle = .roundedRect
        usernameValidLabel.text = "\(minimalUsernameLength)글자 이상입력하쇼"
        usernameValidLabel.font = .systemFont(ofSize: 17)
        usernameValidLabel.textColor = .red
        
        passwordLabel.text = "Password"
        passwordLabel.font = .systemFont(ofSize: 16)
        passwordTextField.borderStyle = .roundedRect
        passwordValidLabel.text = "이것도 \(minimalPasswordLength)글자 이상입력하쇼"
        passwordValidLabel.font = .systemFont(ofSize: 16)
        passwordValidLabel.textColor = .red
        
        signUpButton.backgroundColor = .systemTeal
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitleColor(.gray, for: .disabled)
        
    }
}




