//
//  ScrollingTabController.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import UIKit
import os.log

class ScrollingTabController: UIViewController {

  private let underlayController: UIViewController
  private let tabItemsController: TabItemController

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return underlayController.preferredStatusBarStyle
  }
  init(underlayController: UIViewController, tabItems: [TabItem]) {
    self.underlayController = underlayController
    self.tabItemsController = TabItemController(tabItems: tabItems)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    embed(controller: underlayController, snapToSafeArea: false)
    embed(controller: tabItemsController, edgesToSnap: [.leading, .trailing, .bottom], snapToSafeArea: false)
  }
}
