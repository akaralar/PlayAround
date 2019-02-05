//
//  UIViewController+Containment.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  func embed(controller: UIViewController, edgesToSnap: [UIView.Edge] = UIView.Edge.allCases, snapToSafeArea: Bool = true) {
    addChild(controller)
    view.addSubview(controller.view)
    controller.view.snap(edges: edgesToSnap, to: view, snapToSafeArea: snapToSafeArea)
    controller.didMove(toParent: self)
  }

  func remove(controller: UIViewController) {
    controller.willMove(toParent: nil)
    controller.view.removeFromSuperview()
    controller.removeFromParent()
  }
}
