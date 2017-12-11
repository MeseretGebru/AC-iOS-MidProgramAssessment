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
    var id: Int?
    var name: String?
    var symbol: String?
    var number: Int?
    var weight: Double?
    var meltingC: Double?
    var boilingC: Double?
   
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case weight
        case name
        case symbol
        case meltingC = "melting_c"
        case boilingC = "boiling_c"
    }
}
struct Favorite: Codable {
    var name: String?
    let favorite_element: String?
}






