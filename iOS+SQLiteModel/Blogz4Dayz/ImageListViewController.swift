//
//  ImageListViewController.swift
//  Blogz4Dayz
//
//  Created by Jeff Hurray on 4/12/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import Foundation
import UIKit
import SQLiteModel
import NYTPhotoViewer

class ImageListViewController: UIViewController, ImageCollectionViewDatasource {
    
    let imageCollection = ImageCollectionView(scrollsVertically: true)
    var imageCollectionViewDelegate: ImageCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        
        imageCollectionViewDelegate = ImageCollectionDelegate(navController: self.navigationController)
        imageCollection.delegate = imageCollectionViewDelegate
        imageCollection.dataSource = self
        imageCollection.frame = self.view.bounds
        self.view.addSubview(imageCollection)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageCollection.reload()
    }
    
    // MARK: ImageCollectionViewDatasource
    
    func fetchImagesWithCompletion(completion:(images: [NYTPhoto])->Void) {
        ImageModel.fetchAllInBackground { (images, error) -> Void in
            guard error == nil else {
                print("Error: \(error)")
                completion(images: [])
                return
            }
            let nytImages = images.flatMap({$0 as NYTPhoto})
            completion(images: nytImages)
        }
    }
    
}