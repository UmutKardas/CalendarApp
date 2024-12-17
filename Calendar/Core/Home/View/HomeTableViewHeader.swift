//
//  HomeTableViewHeader.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import SnapKit
import UIKit

class HomeTableViewHeader: UIView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeHeaderViewCell.self, forCellWithReuseIdentifier: HomeHeaderViewCell.identifier)
        return collectionView
    }()

    private var viewModel: HomeViewModel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeTableViewHeader {
    private func setupLayout() {
        addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }

    func setup(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension HomeTableViewHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderViewCell.identifier, for: indexPath) as? HomeHeaderViewCell else {
            return UICollectionViewCell()
        }
        let details = viewModel?.getDayDetails(for: indexPath.row) ?? (0, .Monday)
        cell.configure(dayNumber: details.originalIndex, day: details.day, currentDay: viewModel?.currentDay ?? 0)
        return cell
    }
}
