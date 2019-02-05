//
//  CameraFeedViewController.swift
//  Mediate
//
//  Created by Ahmet Karalar on 4.02.2019.
//  Copyright © 2019 Ahmet Karalar. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import os.log

class CameraFeedViewController: UIViewController {
  enum SessionSetupResult {
    case success
    case failure
  }

  private let session = AVCaptureSession()
  private lazy var queue: DispatchQueue = CameraFeedViewController.makeSetupQueue()
  private lazy var cameraView: CameraFeedView = CameraFeedViewController.makeCameraFeedView()
  private lazy var configurationFailureController = CameraFeedViewController.makeConfigurationFailureController()

  private var setupResult: SessionSetupResult = .success

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    view.addSubview(cameraView)
    cameraView.snap(edges: UIView.Edge.allCases, to: view, snapToSafeArea: false)

    cameraView.session = session
    queue.async {
      self.setupSession()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    queue.async {
      self.startSession()
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setNeedsStatusBarAppearanceUpdate()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    queue.async {
      self.stopSession()
    }
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    setNeedsStatusBarAppearanceUpdate()
  }

  private func setupSession() {
    session.beginConfiguration()
    defer {
      session.commitConfiguration()
    }

    session.sessionPreset = .high

    guard let defaultDevice = defaultCameraDevice() else {
      os_log("Default camera device is not available.")
      setupResult = .failure
      return
    }

    do {
      let input = try AVCaptureDeviceInput(device: defaultDevice)

      if session.canAddInput(input) {
        session.addInput(input)
      } else {
        os_log("Couldn't add video device input to the session.")
        setupResult = .failure
        return
      }
    } catch {
      os_log("Couldn't create video device input: %s", error.localizedDescription)
      setupResult = .failure
      return
    }
  }

  private func defaultCameraDevice() -> AVCaptureDevice? {
    return AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
    ?? AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    ?? AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    ?? nil
  }

  private func startSession() {
    DispatchQueue.main.async {
      self.remove(controller: self.configurationFailureController)
    }

    switch setupResult {
    case .success:
      session.startRunning()
    case .failure:
      DispatchQueue.main.async {
        self.embed(controller: self.configurationFailureController)
      }
    }
  }

  private func stopSession() {
    if self.setupResult == .success {
      self.session.stopRunning()
    }
  }
}

extension CameraFeedViewController {

  static func makeSetupQueue() -> DispatchQueue {
    let queue = DispatchQueue(label: "com.mediate.cameraSetupQueue", qos: .userInitiated)
    return queue
  }

  static func makeCameraFeedView() -> CameraFeedView {
    return CameraFeedView()
  }

  static func makeConfigurationFailureController() -> CustomAlertController {
    return CustomAlertController(description: "Session configuration failed, can't start live video feed", buttonTitle: nil, action: nil)
  }
}
