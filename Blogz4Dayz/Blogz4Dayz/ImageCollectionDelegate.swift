//
//  ImageCollectionDelegate.swift
//  Blogz4Dayz
//
//  Created by Jeff Hurray on 4/9/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import Foundation
import UIKit
import SQLiteModel
import SQLite
import NYTPhotoViewer

class ImageCollectionDelegate : NSObject, ImageCollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var navController: UINavigationController?
    var blog: BlogModel?
    
    init(navController: UINavigationController?, blog: BlogModel? = nil) {
        self.navController = navController
        self.blog = blog
    }
    
    // MARK: ImageCollectionViewDelegate
    
    func imageCollectionViewDidTouchImage(image: NYTPhoto, fromImages: [NYTPhoto]) {
        let viewer = NYTPhotosViewController(photos: fromImages, initialPhoto: image)
        self.navController?.presentViewController(viewer, animated: true, completion: nil)
    }
    
    func imageCollectionViewWantsToAddImage() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        
        navController!.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let data: NSData = UIImageJPEGRepresentation(image, 0.1)!
        if let model = self.blog {
            var images: [ImageModel] = model => BlogModel.Images
            ImageModel.newInBackground([ImageModel.Data <- data], completion: { (newImage, error) -> Void in
                guard error == nil else {
                    return
                }
                images.append(newImage!)
                model.setInBackground(BlogModel.Images, value: images, completion: {
                    picker.dismissViewControllerAnimated(true, completion: nil)
                })
            })
        }
        else {
            ImageModel.newInBackground([ImageModel.Data <- data], completion: { (newImage, error) -> Void in
                picker.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    @objc func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
