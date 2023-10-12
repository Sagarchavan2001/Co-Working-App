//
//  slotsModal.swift
//  Coworking Application
//
//  Created by STC on 10/10/23.
//

import Foundation
struct SlotsApi : Decodable{
    var slots :[Slots]
}
struct Slots : Decodable{
    var Sname : String
    var Sid : Int
    var Sactive : Bool
    enum CodingKeys :String, CodingKey {
        case Sname = "slot_name"
        case Sid = "slot_id"
        case Sactive = "slot_active"
    }
}
