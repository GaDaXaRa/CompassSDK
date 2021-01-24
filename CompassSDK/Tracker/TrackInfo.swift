//
//  TrackInfo.swift
//  CompassSDK
//
//  Created by  on 17/01/2021.
//

import Foundation

struct TrackInfo: Codable {
    private enum CodingKeys : String, CodingKey {
        case
            pageUrl = "url",
            accountId = "ac",
            tik = "a",
            userId = "u",
            userType = "ut",
            startPageTimeStamp = "ps",
            firstVisitTimeStamp = "fv",
            currentTimeStamp = "n",
            visitDuration = "l",
            currentVisitTimeStamp = "t",
            pageId = "p",
            compassVersion = "v",
            sessionId = "s"
    }
    
    var pageUrl: String? {
        didSet {
            guard pageUrl != nil else {
                pageId = nil
                return
            }
            pageId = UUID().uuidString
        }
    }
    var accountId: String?
    var tik = 0
    var conversions = [CompassConversionEvent]()
    var startPageDate: Date? {
        didSet {
            startPageTimeStamp = startPageDate?.timeStamp
        }
    }
    
    var fisrtVisitDate: Date? {
        didSet {
            firstVisitTimeStamp = fisrtVisitDate?.timeStamp
        }
    }
    
    var currentDate: Date? {
        didSet {
            currentTimeStamp = currentDate?.timeStamp
        }
    }
    
    var currentVisitDate: Date? {
        didSet {
            currentVisitTimeStamp = currentVisitDate?.timeStamp
            sessionId = UUID().uuidString
        }
    }
    
    var user: CompassUser? {
        didSet {
            userId = user?.userId
            userType = user?.userType ?? "0"
        }
    }
    
    var compassVersion: String?
    
    var pagesViewed = 0
    
    private var pageId: String?
    private var userId: String?
    private var userType: String?
    private var startPageTimeStamp: Int?
    private var firstVisitTimeStamp: Int?
    private var currentTimeStamp: Int? {
        didSet {
            visitDuration = (currentTimeStamp ?? 0) - (startPageTimeStamp ?? 0)
        }
    }
    private var currentVisitTimeStamp: Int?
    private var visitDuration: Int?
    private var sessionId: String?
}

extension TrackInfo {
    var data: Data {
        self.encode()!
    }
}