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
        label.textColor = UIColor.grayColor
        return label
    }()

    private let dayNumberLabel: UILabel = {
        let label = UILabel()
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
        backgroundColor = UIColor.tableViewColor
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeTableViewCell {
    private func setupLayout() {
        addSubview(dayNameLabel)
        addSubview(dayNumberLabel)
        contentView.addSubview(eventStackView)
    }

    private func setupConstraints() {
        dayNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(24)
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

    func setup(events: [EventItem], viewModel: HomeViewModel) {
        eventStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        events.forEach { addEventView(for: $0, viewModel: viewModel) }

        if let firstEvent = events.first {
            updateDayLabels(for: firstEvent, viewModel: viewModel)
        }
    }

    private func addEventView(for event: EventItem, viewModel: HomeViewModel) {
        let eventItemView = EventItemView()
        eventItemView.setup(eventItem: event, viewModel: viewModel)
        eventStackView.addArrangedSubview(eventItemView)
    }

    private func updateDayLabels(for event: EventItem, viewModel: HomeViewModel) {
        let dayDetails = viewModel.dayDetails(for: event)
        dayNumberLabel.text = "\(dayDetails.originalIndex)"
        dayNameLabel.text = dayDetails.day.rawValue
    }
}

#Preview {
    HomeTableViewCell()
}
