//
//  HomeViewController.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "tableViewColor")
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableView
    }()

    private let addEventButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = UIColor(named: "blueColor")
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var headerView = HomeTableViewHeader()
    private var eventData: [EventItem] = []

    private let viewModel: HomeViewModel = .init(localDatabase: AppContainer.shared.database)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        headerView.setup(viewModel: viewModel)
        setupLayout()
        setupConstraints()
        bindView()
    }
}

private extension HomeViewController {
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(headerView)
        view.addSubview(addEventButton)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.1)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(view.safeAreaLayoutGuide)
        }

        addEventButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }

    private func bindView() {
        viewModel.eventData
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] data in
                self?.eventData = data ?? []
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * 3 + 3 * 4 // yukseklik x count + count + 1 x 3
    }
}

#Preview {
    HomeViewController()
}
