//
//  HomeTableViewCell.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 12.12.2024.
//

import SnapKit
import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"

    private let dayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sat"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "grayColor")
        return label
    }()

    private let dayNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let eventStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "tableViewColor")
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(dayNameLabel)
        addSubview(dayNumberLabel)
        contentView.addSubview(eventStackView)

        for _ in 0 ... 2 {
            let eventItemView = EventItemView()
            eventStackView.addArrangedSubview(eventItemView)
        }
    }

    private func setupConstraints() {
        dayNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(12)
        }

        dayNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(dayNameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(10)
        }

        eventStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(dayNameLabel.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

#Preview {
    HomeTableViewCell()
}
