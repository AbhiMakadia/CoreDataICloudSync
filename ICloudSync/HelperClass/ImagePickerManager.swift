//
//  ImagePickerManager.swift
//  ICloudSync
//
//  Created by Abhi Makadiya on 03/11/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit
import AVKit
import Photos

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController()
    var alert: UIAlertController?
    weak var viewController: UIViewController?
    var pickImageCallback: ((UIImage?) -> Void)?
    
    override init() {
        super.init()
    }
    
    /// PickImage: pick image from device
    ///
    /// - Parameters:
    ///   - viewController: current controller
    ///   - sourceView: for iPad use
    ///   - callback: get image on call back
    func pickImage(_ viewController: UIViewController, sourceView: UIView, showRemovePhoto: Bool, _ callback: @escaping ((UIImage?) -> Void), _ showImage: @escaping ((Bool) -> Void)) {
        
        pickImageCallback = callback
        self.viewController = viewController
        
        let removeImageAction = UIAlertAction(title: R.string.localizable.removePhoto(), style: .default) { UIAlertAction in
            self.removeImage()
        }
        
        let cameraAction = UIAlertAction(title: R.string.localizable.camera(), style: .default) { UIAlertAction in
            self.checkForCameraPermisstion(completion: { (success) in
                if success {
                    self.openCamera()
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let uSelf = self else {
                            return
                        }
                        uSelf.showAlert(title: R.string.localizable.unableToAccessThe() + R.string.localizable.camera(), message: R.string.localizable.toEnableAccessTheCamera())
                    }
                }
            })
        }
        let gallaryAction = UIAlertAction(title: R.string.localizable.photos(), style: .default) { UIAlertAction in
            self.checkForGallryPermisstion(completion: { (success) in
                if success {
                    self.openGallery()
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let this = self else {
                            return
                        }
                        this.showAlert(title: R.string.localizable.unableToAccessThe() + R.string.localizable.photos(), message: R.string.localizable.toEnableAccessThePhotos())
                    }
                    
                }
            })
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { UIAlertAction in
            showImage(false)
        }
        
        // Add the actions
        picker.delegate = self
        var actionArray  = [cameraAction, gallaryAction, cancelAction]
        if showRemovePhoto {
            actionArray.insert(removeImageAction, at: 0)
        }
        alert = UIAlertController.showAlert(title: R.string.localizable.chooseImage(), message: nil, actions: actionArray, preferredStyle: .actionSheet)
        if let alert = alert {
            alert.popoverPresentationController?.sourceView = sourceView
            alert.popoverPresentationController?.sourceRect = CGRect(x: sourceView.bounds.origin.x, y: sourceView.bounds.origin.y, width: sourceView.bounds.width, height: sourceView.bounds.height)
            viewController.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    /// Check For Camera Permisstion
    ///
    /// - Parameter completion: Is permisstion granted or not
    func checkForCameraPermisstion(completion: @escaping (Bool) -> Void) {
        //Camera
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // ask for permissions
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        case .restricted, .denied:
            completion(false)
        case .authorized:
            completion(true)
        // Default case added by swift 5 this will never execute
        @unknown default:
            fatalError("checkForCameraPermisstion")
        }
    }
    
    /// Check For Gallry Permisstion
    ///
    /// - Parameter completion: Is permisstion granted or not
    func checkForGallryPermisstion(completion: @escaping (Bool) -> Void) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(true)
        case .denied, .restricted :
            completion(false)
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization { newStatus in
                switch newStatus {
                case .authorized:
                    completion(true)
                case .denied, .restricted :
                    completion(false)
                case .notDetermined:
                    completion(false)
                @unknown default:
                    completion(false)
                }
            }
        @unknown default:
            completion(false)
        }
        
    }
    
    /// Show Alert
    ///
    /// - Parameters:
    ///   - title: Get alert title
    ///   - message: Get alert message
    func showAlert(title: String, message: String) {
        self.alert?.dismiss(animated: true, completion: nil)
        
        let okAction = UIAlertAction(title: R.string.localizable.ok(), style: .cancel, handler: nil)
        
        let settingsAction = UIAlertAction(title: R.string.localizable.settings(), style: .default, handler: { _ in
            // Take the user to Settings app to possibly change permission.
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    // Finished opening URL
                })
            }
        })
        
        let settingsAlert = UIAlertController.showAlert(title: title, message: message, actions: [okAction, settingsAction], preferredStyle: .alert)
        self.viewController?.present(settingsAlert, animated: true, completion: nil)
    }
    
    /// Open Camera
    func openCamera() {
        DispatchQueue.delay(bySeconds: 0.0) { [weak self] in
            guard let this = self else {
                return
            }
            this.alert?.dismiss(animated: true, completion: nil)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                this.picker.sourceType = .camera
                this.viewController?.present(this.picker, animated: true, completion: nil)
            } else {
                let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { UIAlertAction in
                }
                let alertWarning = UIAlertController.showAlert(title: R.string.localizable.warning(), message: R.string.localizable.youDoNotHaveCamera(), actions: [cancelAction], preferredStyle: .alert)
                if let view = this.viewController?.view {
                    alertWarning.popoverPresentationController?.sourceView = view
                    this.viewController?.present(alertWarning, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    /// Open Gallery
    func openGallery() {
        DispatchQueue.delay(bySeconds: 0.0) { [weak self] in
            guard let this = self else {
                return
            }
            this.alert?.dismiss(animated: true, completion: nil)
            this.picker.sourceType = .photoLibrary
            this.viewController?.present(this.picker, animated: true, completion: nil)
        }
        
    }
    
    /// Remove Image
    func removeImage() {
        pickImageCallback?(nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("Not getting image")
            return
        }
        pickImageCallback?(image)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        print("@objc func imagePickerController called")
    }
    
}
