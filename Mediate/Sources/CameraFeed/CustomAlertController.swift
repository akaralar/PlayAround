//
//  CustomAlertController.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit

class CustomAlertController: UIViewController {

  private let descriptionText: String
  private let buttonTitle: String?
  private let action: (() -> Void)?

  private lazy var descriptionLabel: UILabel = CustomAlertController.makeDescriptionLabel()
  private lazy var button: UIButton = self.makeButton()

  private lazy var stackView: UIStackView = CustomAlertController.makeStackView()
  init(description: String, buttonTitle: String?, action: (() -> Void)?) {
    self.descriptionText = description
    self.buttonTitle = buttonTitle
    self.action = action

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  private func setupViews() {
    view.backgroundColor = .darkGray
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

    descriptionLabel.text = descriptionText
    stackView.addArrangedSubview(descriptionLabel)

    if let title = buttonTitle {
      button.translatesAutoresizingMaskIntoConstraints = false
      button.setTitle(title, for: .normal)
      stackView.addArrangedSubview(button)
    }

    view.addSubview(stackView)
    stackView.snap(edges: [.leading, .trailing], to: view, insets: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40))
    stackView.center(in: view)
  }

  @objc
  private func triggerAction() {
    action?()
  }
}

extension CustomAlertController {
  static func makeDescriptionLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.preferredMaxLayoutWidth = 250
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = .lightGray
    label.textAlignment = .center
    return label
  }

  private func makeButton() -> UIButton {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(triggerAction), for: .touchUpInside)
//    button.setTitleColor(.blue, for: .normal)
    return button
  }

  static func makeStackView() -> UIStackView {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillProportionally
    return stack
  }
}
