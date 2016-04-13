 //
//  ImageCollectionView.swift
//  Blogz4Dayz
//
//  Created by Jeff Hurray on 4/9/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import UIKit
import SQLiteModel
import NYTPhotoViewer

protocol ImageCollectionViewDelegate {
    func imageCollectionViewWantsToAddImage()
    func imageCollectionViewDidTouchImage(image: NYTPhoto, fromImages: [NYTPhoto])
}

protocol ImageCollectionViewDatasource {
    func fetchImagesWithCompletion(completion:(images: [NYTPhoto])->Void)
}

class ImageCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    var delegate: ImageCollectionViewDelegate? = nil
    var dataSource: ImageCollectionViewDatasource? = nil
    
    private let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    private var images: [UIImage] = []
    private var nytImages: [NYTPhoto] = []
    
    convenience init(scrollsVertically: Bool) {
        self.init(frame: CGRectZero)
        
        self.backgroundColor = UIColor.clearColor()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollsVertically ? .Vertical : .Horizontal
        let multiplier: CGFloat = scrollsVertically ? 1.8 : 1.0
        layout.itemSize = CGSize.init(width: 90 * multiplier, height: 120 * multiplier)
        let inset: CGFloat = 4 * multiplier + (scrollsVertically ? 16 : 0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(ImageCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.registerClass(NewImageCell.self, forCellWithReuseIdentifier: "newImageCell")
        self.addSubview(collectionView)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.fillSuperview()
    }
    
    func reload() {
        guard let dataSource = self.dataSource else {
            return
        }
        let loadingView = LoadingView()
        loadingView.attachToView(self)
        dataSource.fetchImagesWithCompletion { imageModels in
            self.nytImages = imageModels
            self.images = imageModels.flatMap({ UIImage(data: $0.imageData!) })
            loadingView.remove()
            self.collectionView.reloadData()
            self.setNeedsLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard indexPath.row > 0 else {
            self.delegate?.imageCollectionViewWantsToAddImage()
            return
        }
        let image = nytImages[indexPath.row - 1]
        self.delegate?.imageCollectionViewDidTouchImage(image, fromImages: nytImages)
    }
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard indexPath.row > 0 else {
            let addCell = collectionView.dequeueReusableCellWithReuseIdentifier("newImageCell", forIndexPath: indexPath) as! NewImageCell
            return addCell
        }
        let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCell
        let image = images[indexPath.row - 1]
        imageCell.image = image
        return imageCell
    }
    
}
