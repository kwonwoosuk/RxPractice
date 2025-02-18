//
//  NumbersViewController.swift
//  RxPractice
//
//  Created by 권우석 on 2/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit



class NumbersViewController: ViewController {
    
    
    private var number1 = UITextField()
    private var number2 = UITextField()
    private var number3 = UITextField()
    
    private var plus = UILabel()
    private var line = UIView()
    private var result = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
        .map { $0.description }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    func setUI() {
        navigationItem.title = "Adding Numbers"
        view.backgroundColor = .white
        
        [number1, number2, number3, plus, line, result].forEach { view.addSubview($0) }
        
        number1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        
        plus.snp.makeConstraints { make in
            make.trailing.equalTo(number3.snp.leading).offset(-12)
            make.centerY.equalTo(number3)
            make.height.equalTo(44)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(1)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        
        plus.text = "+"
        plus.font = .systemFont(ofSize: 20)
        
        line.backgroundColor = .lightGray
        result.textAlignment = .center
        number1.borderStyle = .roundedRect
        number2.borderStyle = .roundedRect
        number3.borderStyle = .roundedRect
    }
}
