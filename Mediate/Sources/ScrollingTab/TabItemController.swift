//
//  TabItemController.swift
//  Mediate
//
//  Created by Ahmet Karalar on 5.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TabItemController: UIViewController {
  private lazy var tabItemCollectionView: UICollectionView = self.makeTabItemCollectionView()

  private let tabItems: [TabItem]
  private(set) var selectedIndex: Int?

  init(tabItems: [TabItem]) {
    self.tabItems = tabItems
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBlurAndVibrancy()
    setupTabItems()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  private func setupBlurAndVibrancy() {
    view.backgroundColor = .clear

    let effect = UIBlurEffect(style: .light)
    let effectView = UIVisualEffectView(effect: effect)
    effectView.translatesAutoresizingMaskIntoConstraints = false

    view.insertSubview(effectView, at: 0)

    effectView.snap(edges: [.top, .bottom, .leading, .trailing], to: view)
    effectView.setHeight(96)

    let vibrancy = UIVibrancyEffect(blurEffect: effect)
    let vibrancyView = UIVisualEffectView(effect: vibrancy)
    vibrancyView.translatesAutoresizingMaskIntoConstraints = false

    vibrancyView.contentView.addSubview(tabItemCollectionView)
    effectView.contentView.addSubview(vibrancyView)

    vibrancyView.snap(edges: UIView.Edge.allCases, to: effectView.contentView)
  }

  private func setupTabItems() {
    tabItemCollectionView.snap(edges: [.top, .bottom, .leading, .trailing], to: view)
    tabItemCollectionView.setHeight(96)

    tabItemCollectionView.register(TabItemCell.self, forCellWithReuseIdentifier: TabItemCell.reuseIdentifier)
  }
}


extension TabItemController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabItemCell.reuseIdentifier, for: indexPath) as! TabItemCell
    cell.populate(tabItem: tabItems[indexPath.row], isSelected: selectedIndex == indexPath.item)
    return cell
  }
}

extension TabItemController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if selectedIndex == indexPath.item {
      selectedIndex = nil
    } else {
      selectedIndex = indexPath.item
    }
    collectionView.reloadData()
    os_log("Did select item: %s", tabItems[indexPath.item].title)
  }
}

extension TabItemController {
  func makeTabItemCollectionView() -> UICollectionView {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 75, height: 75)

    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.delegate = self
    cv.dataSource = self
    cv.backgroundColor = .clear
    cv.showsHorizontalScrollIndicator = false
    cv.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    return cv
  }
}
