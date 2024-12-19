//
//  DateInputView.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 19.12.2024.
//

import RxCocoa
import RxSwift
import UIKit

class DateInputView: UIView {
    private lazy var eventInputView: EventInputView = {
        let view = EventInputView()
        view.placeHolder = "Enter Date"
        view.iconNamed = "calendar"
        return view
    }()

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "en_US")
        return picker
    }()

    var eventDatePicker: UIDatePicker {
        return datePicker
    }

    var placeHolder: String = "Enter Title" {
        didSet {
            eventInputView.placeHolder = placeHolder
        }
    }

    var iconNamed: String = "calendar" {
        didSet {
            eventInputView.iconNamed = iconNamed
        }
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

extension DateInputView {
    private func setupView() {
        eventInputView.textField.inputView = datePicker
        eventInputView.textField.inputAccessoryView = UIToolbar.doneToolbar(target: self, action: #selector(dismissPicker))
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    private func setupLayout() {
        addSubview(eventInputView)
    }

    private func setupConstraints() {
        eventInputView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc private func dismissPicker() {
        eventInputView.textField.resignFirstResponder()
    }

    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM dd h:mm a"
        eventInputView.textField.text = formatter.string(from: datePicker.date)
    }
}
