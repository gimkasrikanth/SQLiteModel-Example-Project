//
//  ImageModel.swift
//  Blogz4Dayz
//
//  Created by Jeff Hurray on 4/9/16.
//  Copyright © 2016 jhurray. All rights reserved.
//

import Foundation
import SQLiteModel
import SQLite
import NYTPhotoViewer

@objc final class ImageModel: NSObject, SQLiteModel, NYTPhoto {
    
    var localID: Int64 = -1
    
    required override init() {}

    
    static let Data = Expression<NSData>("data")
    
    
    static func buildTable(tableBuilder: TableBuilder) {
        tableBuilder.column(Data)
    }
    
    // MARK: Image
    
    var image: UIImage? {
        let data = self => ImageModel.Data
        return UIImage(data: data)
    }
    
    var imageData: NSData? {
        return self => ImageModel.Data
    }
    
    var placeholderImage: UIImage? {
        return image
    }
    
    var attributedCaptionTitle: NSAttributedString? {
        return nil
    }
    
    var attributedCaptionSummary: NSAttributedString? {
        return nil
    }
    
    var attributedCaptionCredit: NSAttributedString? {
        return nil
    }

}