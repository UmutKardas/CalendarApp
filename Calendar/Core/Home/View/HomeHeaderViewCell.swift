//
//  HomeHeaderViewCell.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 4.12.2024.
//

import SnapKit
import UIKit

class HomeHeaderViewCell: UICollectionViewCell {
    static let identifier: String = "HomeHeaderViewCell"

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.grayColor
        label.textAlignment = .center
        return label
    }()

    private let dayNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderViewCell {
    private func setupLayout() {
        addSubview(dayLabel)
        addSubview(dayNumberLabel)
    }

    private func setupConstraints() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }

        dayNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }

    func configure(dayNumber: Int, day: Day, currentDay: Int) {
        dayLabel.text = day.rawValue
        dayNumberLabel.text = "\(dayNumber)"
        dayNumberLabel.textColor = currentDay == dayNumber ? .white : .label
        dayNumberLabel.backgroundColor = currentDay == dayNumber ? UIColor(named: "blueColor") : .clear
    }
}

#Preview {
    HomeHeaderViewCell()
}
