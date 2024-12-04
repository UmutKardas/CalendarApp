//
//  HomeViewController.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "tableViewColor")
        return tableView
    }()

    private lazy var headerView = HomeTableViewHeader()

    private let viewModel: HomeViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }

    private func bindView() {}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        cell.backgroundColor = UIColor(named: "tableViewColor")
        return cell
    }
}

#Preview {
    HomeViewController()
}
