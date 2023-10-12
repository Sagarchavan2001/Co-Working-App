//
//  slotsViewModal.swift
//  Coworking Application
//
//  Created by STC on 10/10/23.
//

import Foundation
final class SlotsViewModal{
    var slots1:[Slots] = []
    var eventHandler : ((_ event: Event2) -> Void)?
    
    func fetchSlots(){
        self.eventHandler.self?(.loading)
        DeskApiManager.shared.SlotsApiManager{ responnce in
            self.eventHandler?(.stopLoading)
            switch responnce{
            case .success(let DeskSlots) :
            
                self.slots1 = DeskSlots.slots.self
         
                self.eventHandler?(.dataLoaded)
            case .failure(let error) :
                print(error)
                self.eventHandler?(.error(_error: error))
            }
        }
    }
}
extension  SlotsViewModal{
    enum Event2{
        case loading
        case stopLoading
        case dataLoaded
        case error(_error : Error?)
    }
}
