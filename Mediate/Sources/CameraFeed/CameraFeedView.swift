//
//  CameraFeedView.swift
//  Mediate
//
//  Created by Ahmet Karalar on 5.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import UIKit
import AVFoundation

class CameraFeedView: UIView {
  var videoLayer: AVCaptureVideoPreviewLayer {
    guard let layer = layer as? AVCaptureVideoPreviewLayer else {
      fatalError("Layer should be of type AVCaptureVideoPreviewLayer")
    }

    return layer
  }

  var session: AVCaptureSession? {
    get {
      return videoLayer.session
    }
    set {
      videoLayer.session = newValue
    }
  }

  override class var layerClass: AnyClass {
    return AVCaptureVideoPreviewLayer.self
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
    backgroundColor = .black
    videoLayer.videoGravity = .resizeAspectFill
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

