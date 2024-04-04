//
//  Events.swift
//  dcsFirebase
//
//  Created by جبران on 13/01/2024.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore


struct DcsEvents: Identifiable,Codable,Equatable,Hashable {
    @DocumentID var id: String?
    var location:String
    var eventDate:Date
    var eventText:String
    var eventStatus:String
    var eventTime:Date
    var eventSynch:String
    var eventFSNL:String
    var eventRatching:String
    var eventNote:String
    var eventUsername:String
    
    enum CodingKeys: CodingKey{
        case id
        case location
        case eventDate
        case eventText
        case eventStatus
        case eventTime
        case eventFSNL
        case eventSynch
        case eventRatching
        case eventNote
        case eventUsername
         
    }
    
    
}


 
extension Formatter {
    static let iso8601withFractionalSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

