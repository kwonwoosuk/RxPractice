//
//  SimpleTableViewController.swift
//  RxPractice
//
//  Created by 권우석 on 2/26/25.
//

//  SimpleTableViewController.swift
import UIKit
import SnapKit
//
//struct Product {
//    let name: String
//    let price = Int.random(in: 1...10000) * 1000
//    let count = Int.random(in: 1...10)
//} -> collectionView에서 사용할것

final class SimpleTableViewController: UIViewController {

    private lazy var tableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .white
        view.register(UITableViewCell.self, forCellReuseIdentifier: "simpleCell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SimpleTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell")!
        var content = cell.defaultContentConfiguration()
        
        content.text = "기냥텍스트"
        content.secondaryText = "두번쨰 텍스트"
        content.image = UIImage(systemName: "heart")
        content.textProperties.color = .black
        content.imageProperties.tintColor = .systemPink
        content.imageProperties.cornerRadius = 10
        
        cell.contentConfiguration = content
        return cell
    }
    
    
}
