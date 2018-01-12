//
//  Event.swift
//  LinkUp
//
//  Created by Del Shawn Kirksey on 8/16/17.
//  Copyright © 2017 Del Shawn Kirksey. All rights reserved.
//

import Foundation

class Event {
    private var _eventID: String
    private var _eventTitle: String
    private var _eventDescription: String
    private var _eventStartDate: Date
    private var _eventEndDate: Date
    private var _eventLocation: String
    private var _eventInvitees: [String]
    
    init(title: String, description: String, startDate: Date, endDate: Date, location: String, invitees: [String]) {
        self._eventID = "E90847"
        self._eventTitle = "Title"
        self._eventDescription = description
        self._eventStartDate = startDate
        self._eventEndDate = endDate
        self._eventLocation = location
        self._eventInvitees = invitees
    }
}

class EventType {
    
}

