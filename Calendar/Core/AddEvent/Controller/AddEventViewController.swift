//
//  AddEventViewController.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 18.12.2024.
//

import RxCocoa
import RxSwift
import UIKit

class AddEventViewController: UIViewController {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Event"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        return label
    }()

    private lazy var titleTextField: EventInputView = {
        let textField = EventInputView()
        textField.placeHolder = "Enter Title"
        textField.iconNamed = "pencil"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var startDateTextField: DateInputView = {
        let textField = DateInputView()
        textField.placeHolder = "Enter Start Date"
        textField.iconNamed = "calendar.badge.clock"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var endDateTextField: DateInputView = {
        let textField = DateInputView()
        textField.placeHolder = "Enter End Date"
        textField.iconNamed = "calendar.badge.checkmark"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Calendar", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let viewModel: AddEventViewModel = .init(database: AppContainer.shared.database)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupConstraints()
        bindView()
    }
}

extension AddEventViewController {
    private func setupView() {
        view.backgroundColor = UIColor.tableViewColor
    }

    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(startDateTextField)
        view.addSubview(endDateTextField)
        view.addSubview(addButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }

        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }

        startDateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }

        endDateTextField.snp.makeConstraints { make in
            make.top.equalTo(startDateTextField.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(endDateTextField.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(60)
        }
    }

    private func bindView() {
        titleTextField.textField.rx.text
            .orEmpty
            .bind(to: viewModel.title)
            .disposed(by: disposeBag)

        startDateTextField.eventDatePicker.rx.date
            .subscribe { [weak self] date in
                self?.viewModel.startDate.accept(date.timeIntervalSince1970)
            }
            .disposed(by: disposeBag)

        endDateTextField.eventDatePicker.rx.date
            .subscribe { [weak self] date in
                self?.viewModel.endDate.accept(date.timeIntervalSince1970)
            }
            .disposed(by: disposeBag)

        addButton.rx.tap
            .bind { [weak self] in
                if self?.viewModel.addEvent() == true {
                    self?.navigationController?.pushViewController(HomeViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag)

        viewModel.error.subscribe { [weak self] error in
            let alert = UIAlertController.showAlert(title: "Error", message: error)
            self?.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
}

#Preview {
    AddEventViewController()
}
