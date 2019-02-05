//
//  Icon.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String, CaseIterable {
  case chair
  case desk
  case door
  case girl
  case lift
  case microphone
  case stairs
  case trashcan

  var image: UIImage? {
    return UIImage(imageLiteralResourceName: rawValue).withRenderingMode(.alwaysTemplate)
  }
}
