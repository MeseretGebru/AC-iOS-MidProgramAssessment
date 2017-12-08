//
//  ElementsAPIClient.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//
import Foundation
import UIKit

struct ElementsAPIClient {
    private init(){}
    static let shared = ElementsAPIClient()
    func getElements(from urlStr: String,
                   completionHandler: @escaping ([ElementInfo]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        //let APIKey = ""  //"7289999-27d8716686d599947ed35246c"
        //let filter = urlStr.replacingOccurrences(of: " ", with: "+")
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        
        //"https://pixabay.com/api/?key=\(APIKey)&q=\(filter)&image_type=photo"
      //guard let url = URL(string: urlStr) else {return}
        
        guard let authenticatedRequest = buildAuthRequest(from: urlStr, httpVerb: .GET) else { errorHandler(AppError.badURL); return }
        
        let parseDataIntoElementArr: (Data) -> Void = {(data: Data) in
            do {
                let onlineElements = try JSONDecoder().decode([ElementInfo].self, from: data)
                completionHandler(onlineElements)
            }
            catch {
                print(error)
            }
        }
        //URLRequest(url: url),
        NetworkHelper.manager.performDataTask(with: authenticatedRequest,
                                              completionHandler: parseDataIntoElementArr,
                                              errorHandler: errorHandler)
    }

private func buildAuthRequest(from urlStr: String, httpVerb: HTTPVerb) -> URLRequest? {
    guard let url = URL(string: urlStr) else { return nil }
    var request = URLRequest(url: url)
    let userName = "key-1"
    let password = "ptJP0XOFIQ_xysF7nwoB"
    let authStr = buildAuthStr(userName: userName, password: password)
    if httpVerb == .POST {
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    return request
}
private func buildAuthStr(userName: String, password: String) -> String {
    let nameAndPassStr = "\(userName):\(password)"
    let nameAndPassData = nameAndPassStr.data(using: .utf8)!
    let authBase64Str = nameAndPassData.base64EncodedString()
    let authStr = "Basic \(authBase64Str)"
    return authStr
}

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
    // MARK: - Posting...
    
    func post(favorite: Favorite, errorHandler: @escaping (Error) -> Void) {
        let urlStr = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/favorites"
        guard var authPostRequest = buildAuthRequest(from: urlStr, httpVerb: .POST) else {errorHandler(AppError.badURL); return }
        do {
            let encodedOrder = try JSONEncoder().encode(favorite)
            authPostRequest.httpBody = encodedOrder
            NetworkHelper.manager.performDataTask(with: authPostRequest,
                                                  completionHandler: {_ in print("Made a post request")},
                                                  errorHandler: errorHandler)
        }
        catch {
            errorHandler(AppError.codingError(rawError: error))
        }
        
        
    }
    
}

//class ImageAPIClient {
//    private init() {}
//    static let manager = ImageAPIClient()
//    func loadImage(from urlStr: String,
//                   completionHandler: @escaping (UIImage) -> Void,
//                   errorHandler: @escaping (Error) -> Void) {

//          let urlStr = "http://www.theodoregray.com/periodictable/Tiles/// ElementNumberWithThreeDigits/s7.JPG"
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

