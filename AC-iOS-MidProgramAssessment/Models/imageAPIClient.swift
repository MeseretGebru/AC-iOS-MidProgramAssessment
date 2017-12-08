//
//  imageAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit



import Foundation
import UIKit
class ImageAPIClient{
    private init() {}
    static let manager = ImageAPIClient()
    
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL)
            return
        }
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(AppError.notAnImage)
                return
            }
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: urlRequest,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

//class ImageAPIClient {
//    private init() {}
//    static let manager = ImageAPIClient()
//    func loadImage(from urlStr: String,
//                   completionHandler: @escaping (UIImage) -> Void,
//                   errorHandler: @escaping (Error) -> Void) {
//        guard let url = URL(string: urlStr) else {return}
//        let completion = {(data: Data) in
//            guard let onlineImage = UIImage(data: data) else {return}
//            completionHandler(onlineImage)
//        }
//        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
//                                              completionHandler: completion,
//                                              errorHandler: errorHandler)
//    }
//}

