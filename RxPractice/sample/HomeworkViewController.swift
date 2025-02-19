//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}

class HomeworkViewController: UIViewController {
    
    private let viewModel = HomeworkViewModel()
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        let input = HomeworkViewModel.Input(
            searchButtonClicked: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty,
            itemSelected: tableView.rx.modelSelected(Person.self)
        )
        
        let output = viewModel.transform(input: input)
        
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier:  PersonTableViewCell.identifier,
                                       cellType: PersonTableViewCell.self)) { (row, element, cell) in // element사용하기
                let url = URL(string: element.profileImage)
                cell.profileImageView.kf.setImage(with: url)
                cell.usernameLabel.text = element.name
                
                cell.detailButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let vc = DetailViewController()
                        vc.navigationItem.title = element.name
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        
        output.selectedUsers
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier,
                                            cellType: UserCollectionViewCell.self)) { (row, person, cell) in
                cell.label.text = person.name
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}

