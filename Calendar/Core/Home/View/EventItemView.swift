//
//  EventItemView.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 16.12.2024.
//

import SnapKit
import UIKit

class EventItemView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Learning English"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "1:00 PM - 2:00 PM"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4
        view.layer.masksToBounds = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventItemView {
    func setup(eventItem: EventItem, viewModel: HomeViewModel) {
        let inProgress = viewModel.isEventInProgress(eventItem: eventItem)
        titleLabel.text = eventItem.title
        descriptionLabel.text = formatEventTimeRange(eventItem: eventItem)
        cellBackgroundView.backgroundColor = inProgress ? UIColor.blueColor : UIColor.white
        titleLabel.textColor = inProgress ? UIColor.white : UIColor.black
        descriptionLabel.textColor = inProgress ? UIColor.white : UIColor.grayColor
    }

    private func setupLayout() {
        addSubview(cellBackgroundView)

        cellBackgroundView.addSubview(titleLabel)
        cellBackgroundView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        cellBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cellBackgroundView.snp.centerY).offset(-10)
            make.left.equalToSuperview().offset(15)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cellBackgroundView.snp.centerY).offset(10)
            make.left.equalToSuperview().offset(15)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }

        snp.makeConstraints { make in
            make.height.equalTo(100)
        }
    }

    private func formatEventTimeRange(eventItem: EventItem) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, h:mm a"
        let startDateString = dateFormatter.string(from: eventItem.startDate)
        let endDateString = dateFormatter.string(from: eventItem.endDate)

        return "\(startDateString)-\(endDateString)"
    }
}
