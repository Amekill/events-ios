//
//  ImageHelper.swift
//  Events
//
//  Created by Alexey Kostenko on 6/18/20.
//  Copyright © 2020 Alexey Kostenko. All rights reserved.
//

import UIKit

struct ImageHelper {
    
    static func saveImageInDocumentDirectory(image: UIImage, fileName: String) {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL, options: .atomic)
        }
    }
    
    static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {}
        
        return nil
    }
    
    static func deleteImageFromDocumentDirectory(fileName: String) {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {}
    }
}
