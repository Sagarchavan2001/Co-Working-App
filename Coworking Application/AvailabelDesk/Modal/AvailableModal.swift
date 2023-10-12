//
//  AvailableModal.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
struct AvailableApi : Decodable{
   
    var availability :[Availability]
}
struct Availability : Decodable{
    var deskId : Int
    var name : String
    var Active : Bool
    enum CodingKeys :String, CodingKey {
        case deskId = "workspace_id"
        case name = "workspace_name"
        case Active = "workspace_active"
    }
}
