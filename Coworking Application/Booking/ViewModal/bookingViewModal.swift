//
//  bookingViewModal.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
final class BookingViewModal{
    var bookigs1:[Booking] = []
    var eventHandler : ((_ event: Event) -> Void)?
    
    func fetchBooking(){
        self.eventHandler.self?(.loading)
        ApiManager.shared.fetchingApi { responnce in
            self.eventHandler?(.stopLoading)
            switch responnce{
            case .success(let booking1) :
            
                self.bookigs1 = booking1.bookings.self
         
                self.eventHandler?(.dataLoaded)
            case .failure(let error) :
                print(error)
                self.eventHandler?(.error(_error: error))
            }
        }
    }
}
extension  BookingViewModal{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(_error : Error?)
    }
}
