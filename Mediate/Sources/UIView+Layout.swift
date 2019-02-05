//
//  UIView+Layout.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  enum Edge: CaseIterable {
    case leading
    case trailing
    case top
    case bottom
  }

  func leadingAnchor(safe: Bool) -> NSLayoutXAxisAnchor {
    if safe {
      return safeAreaLayoutGuide.leadingAnchor
    } else {
      return leadingAnchor
    }
  }

  func trailingAnchor(safe: Bool) -> NSLayoutXAxisAnchor {
    if safe {
      return safeAreaLayoutGuide.trailingAnchor
    } else {
      return trailingAnchor
    }
  }

  func topAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
    if safe {
      return safeAreaLayoutGuide.topAnchor
    } else {
      return topAnchor
    }
  }

  func bottomAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
    if safe {
      return safeAreaLayoutGuide.bottomAnchor
    } else {
      return bottomAnchor
    }
  }

  func snap(edges: [Edge], to view: UIView, insets: UIEdgeInsets = .zero, snapToSafeArea: Bool = true) {
    translatesAutoresizingMaskIntoConstraints = false
    let constraints = edges.map { edge -> NSLayoutConstraint in
      switch edge {
      case .leading:
        return leadingAnchor.constraint(equalTo: view.leadingAnchor(safe: snapToSafeArea), constant: insets.left)
      case .trailing:
        return trailingAnchor.constraint(equalTo: view.trailingAnchor(safe: snapToSafeArea), constant: -insets.right)
      case .bottom:
        return bottomAnchor.constraint(equalTo: view.bottomAnchor(safe: snapToSafeArea), constant: -insets.bottom)
      case .top:
        return topAnchor.constraint(equalTo: view.topAnchor(safe: snapToSafeArea), constant: insets.top)
      }
    }
    NSLayoutConstraint.activate(constraints)
  }

  func setHeight(_ height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }

  func center(in view: UIView) {
    let constraints = [
      centerXAnchor.constraint(equalTo: view.centerXAnchor),
      centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ]
    NSLayoutConstraint.activate(constraints)
  }
}
