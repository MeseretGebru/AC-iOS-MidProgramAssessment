//
//  Elements.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by C4Q on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum HTTPVerb{
    case POST
    case GET
}

struct ElementInfo: Codable {
    var id: Int
    var name: String?
    var symbol: String?
    var number: Int?
    var weight: Double?
    var melting_c: Int?
    var boiling_c: Int?
    //var discovery_year: Int
}

struct Favorite: Codable {
    var id: Int?
    var record_url: String?
    var name: String?
    let favorite_element: String?
}






