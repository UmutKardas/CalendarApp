//
//  EventInputView.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 18.12.2024.
//

import SnapKit
import UIKit

class EventInputView: UIView {
    private let colorBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        return view
    }()

    private let eventTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor.lightGray
        textField.borderStyle = .none
        return textField
    }()

    private let calendarIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = UIColor.systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var placeHolder: String = "Enter Title" {
        didSet {
            eventTitleTextField.placeholder = placeHolder
        }
    }

    var iconNamed: String = "calendar" {
        didSet {
            calendarIconImageView.image = UIImage(systemName: iconNamed)
        }
    }

    var textField: UITextField {
        return eventTitleTextField
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventInputView {
    private func setupView() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }

    private func setupLayout() {
        addSubview(colorBar)
        addSubview(eventTitleTextField)
        addSubview(calendarIconImageView)
    }

    private func setupConstraints() {
        colorBar.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(6)
        }

        calendarIconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        eventTitleTextField.snp.makeConstraints { make in
            make.leading.equalTo(colorBar.snp.trailing).offset(8)
            make.trailing.equalTo(calendarIconImageView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
}

#Preview {
    EventInputView()
}
