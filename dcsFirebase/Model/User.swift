//
//  User.swift
//  dcs
//
//  Created by جبران on 21/05/1444 AH.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable,Codable {
    @DocumentID var id: String?
    var username: String
    var userUID: String
    var userEmail: String
    var userProfileURL: URL
    var userPhone: String
    var userProfileName: String
    
    enum CodingKeys: CodingKey {
        case id
        case username
        case userUID
        case userEmail
        case userProfileURL
        case userPhone
        case userProfileName
    }
    
}


extension User {
    enum Fonts:String{
        case bold = "GESSTwoMedium-Medium"
        case light = "GESSTwoLight-Light"
    }
}
