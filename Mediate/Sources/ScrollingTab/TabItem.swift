//
//  TabItem.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit

struct TabItem {
  let title: String
  let icon: Icon
}

extension TabItem {
  init(icon: Icon) {
    title = icon.rawValue
    self.icon = icon
  }
}

