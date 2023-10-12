//
//  AvailabilityApiManager.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
enum DataError1: Error{
case invalidResponce
case invalidUrl
case invalidData
case message(_error : Error?)

}
typealias Handler1 = (Result<AvailableApi,DataError1>) -> Void

final class AvailableApiManager{
static let shared =  AvailableApiManager()
private init(){}

func AvailableApiFetch(completion : @escaping Handler1){
    guard let url = URL(string: AvailableConstat.AvailableApi.AvailableApiUrl)else{
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
            let Available  = try JSONDecoder().decode(AvailableApi.self, from: data)
            completion(.success(Available))
        }catch{
            completion(.failure(.message(_error: error)))
        }
    }.resume()
    
}
}
