//
//  BookingApiManager.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
enum DataError: Error{
    case invalidResponce
    case invalidUrl
    case invalidData
    case message(_error : Error?)
    
}
typealias Handler = (Result<BookingApi,DataError>) -> Void
final class ApiManager{
    static let shared =  ApiManager()
    private init(){}
    
    func fetchingApi(completion : @escaping Handler){
        guard let url = URL(string: Constant.Api.BookingApiUrl)else{
            return
        }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data , error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let responce = responce as? HTTPURLResponse, 200...299 ~=  responce.statusCode else{
                completion(.failure(.invalidResponce))
                return
            }
            do {
                let Booking  = try JSONDecoder().decode(BookingApi.self, from: data)
                completion(.success(Booking))
            }catch{
                completion(.failure(.message(_error: error)))
            }
        }.resume()
    }
}
