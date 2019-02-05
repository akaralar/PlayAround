//
//  CameraFeedViewController.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class CameraFeedController: UIViewController {

  private var current: UIViewController?

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return current?.preferredStatusBarStyle ?? .default
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateCurrentController()
  }

  private func updateCurrentController() {
    if let current = current {
      remove(controller: current)
      self.current = nil
    }

    let child = controller(for: AVCaptureDevice.authorizationStatus(for: .video))
    embed(controller: child, snapToSafeArea: false)
    current = child

    setNeedsStatusBarAppearanceUpdate()
  }

  private func controller(for status: AVAuthorizationStatus) -> UIViewController {
    switch status {
    case .authorized:
      return CameraFeedViewController()
    case .denied:
      return CustomAlertController(
        description: "Camera access is denied, please go to settings and allow camera access to see a live feed",
        buttonTitle: "Open Settings...",
        action: {
          if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
          }
      })
    case .notDetermined:
      return CustomAlertController(
        description: "Camera access is required to see live feed, please allow access after tapping \"Continue\".",
        buttonTitle: "Continue",
        action: { [weak self] in
          AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in
            DispatchQueue.main.async {
              self?.updateCurrentController()
            }
          })
      })
    case .restricted:
      return CustomAlertController(
        description: "Camere is unavailable :(",
        buttonTitle: "Try again",
        action: { [weak self] in
          self?.updateCurrentController()
        })
    }
  }
}
