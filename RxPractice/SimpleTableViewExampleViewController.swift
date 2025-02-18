//
//  ViewController.swift
//  RxPractice
//
//  Created by 권우석 on 2/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
//핵심
// 테이블뷰 셀클릭, 악세사리 클릭시 얼럿 띄우기
class SimpleTableViewExampleViewController: UIViewController , UITableViewDelegate {
    
    // extension없이도 간단하게 테이블뷰를 구현할 수 있는거 아니였나여 쟤는 되고 난 왜 안시켜줘
    
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    //야~!~! 얘들아 나 뛴다 ~!!~ 관심 좀 ~!~! 하는 느낌 봐주는 애 없으면 그냥 평생 이러고 있는거
    private let items = Observable.just(
        (0...30).map { "\($0)번 테이블뷰 셀"}
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "SimpleTableView"
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        items // bind: 아 봐줄게 뭐 어떻게 해줄까
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) \(row)번째"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx // DidSelectedRow 와 같은동작
            .modelSelected(String.self)
            .bind(with: self) { owner, value in
                owner.showAlert(message: "\(value) 선택") {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx
            .itemAccessoryButtonTapped
            .bind(with: self) { owner, indexPath in
                owner.showAlert(message: "선택한 악세서리 \(indexPath.section), \(indexPath.row)") {
                    owner.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    
    
    
}

