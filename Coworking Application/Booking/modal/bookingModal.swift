//
//  bookingModal.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
struct BookingApi : Decodable{
   
    var bookings :[Booking]
}
struct Booking : Decodable{
    var deskId : Int
    var name : String
    var bookedOn : String
    enum CodingKeys :String, CodingKey {
        case deskId = "workspace_id"
        case name = "workspace_name"
        case bookedOn = "booking_date"
    }
}
