//
//  AvailableViewModal.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
final class AvailableViewModal{
    var Available1:[Availability] = []
    var eventHandler : ((_ event: Event1) -> Void)?
    
    func fetchAvailable(){
        self.eventHandler.self?(.loading)
        AvailableApiManager.shared.AvailableApiFetch { responnce in
            self.eventHandler?(.stopLoading)
            switch responnce{
            case .success(let Available1) :
            
                self.Available1 = Available1.availability.self
         
                self.eventHandler?(.dataLoaded)
            case .failure(let error) :
                print(error)
                self.eventHandler?(.error(_error: error))
            }
        }
    }
}
extension  AvailableViewModal{
    enum Event1{
        case loading
        case stopLoading
        case dataLoaded
        case error(_error : Error?)
    }
}

