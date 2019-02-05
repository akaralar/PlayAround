//
//  TabItemCell.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit

class TabItemCell: UICollectionViewCell {
  private let imageView: UIImageView = TabItemCell.makeImageView()
  private let titleLabel: UILabel = TabItemCell.makeTitleLabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)

    imageView.snap(edges: [.top, .leading, .trailing], to: contentView, insets: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5))
    imageView.setHeight(50)
    titleLabel.snap(edges: [.leading, .trailing, .bottom], to: contentView, insets: UIEdgeInsets(top: 0, left: 5, bottom: 2, right: 5))
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil

  }

  func populate(tabItem: TabItem, isSelected: Bool) {
    titleLabel.text = tabItem.title
    imageView.image = tabItem.icon.image

    if isSelected {
      contentView.backgroundColor = .init(white: 0.0, alpha: 0.2)
    } else {
      contentView.backgroundColor = .clear
    }
  }
}

extension TabItemCell {
  static var reuseIdentifier: String {
    return String(describing: self)
  }

  static func makeImageView() -> UIImageView {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
  }

  static func makeTitleLabel() -> UILabel {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 12, weight: .light)
    label.textAlignment = .center
    label.adjustsFontSizeToFitWidth = true
    return label
  }
}
