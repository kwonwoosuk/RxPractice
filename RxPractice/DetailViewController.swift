//
//  DetailViewController.swift
//  RxPractice
//
//  Created by 권우석 on 2/19/25.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DetailViewController: UIViewController {
    
    let nextButton = PointButton(title: "뻐튼")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = .lightGray
        
        // 내일 할것에 대한 이야기
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view)
        }
    }
    
    func bind() {
        
        let tap = nextButton.rx.tap
            .map { Int.random(in: 1...100) }
            .share()
        
        
        tap
            .bind(with: self) { owner, value in
                print("1번 - \(value)")
            }
            .disposed(by: disposeBag)
        
        tap
            .bind(with: self) { owner, value in
                print("2번 - \(value)")
            }
            .disposed(by: disposeBag)
        
        
        tap
            .bind(with: self) { owner, value in
                print("3번 - \(value)")
            }
            .disposed(by: disposeBag)
    }
}
