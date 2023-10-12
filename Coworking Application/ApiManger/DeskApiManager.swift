//
//  DeskApiManager.swift
//  Coworking Application
//
//  Created by STC on 10/10/23.
//

import Foundation
enum DataError2: Error{
case invalidResponce
case invalidUrl
case invalidData
case message(_error : Error?)

}
typealias Handler2 = (Result<SlotsApi,DataError2>) -> Void

final class DeskApiManager{
    static let shared =  DeskApiManager()
    private init(){}
    
    func SlotsApiManager(completion : @escaping Handler2){
        guard let url = URL(string:DeskConstant.SlotsApi.SlotsApiUrl)else{
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
                let slotsData  = try JSONDecoder().decode(SlotsApi.self, from: data)
                completion(.success(slotsData))
            }catch{
                completion(.failure(.message(_error: error)))
            }
        }.resume()
        
    }
    func BookingConfirmApiManager(date : String, slotsId : String , workspaceId : String, type : String)
    {
        let url = URL(string:DeskConstant.bookingConfirmApi.ConfirmApiUrl)!
        let jsonDict = ["date":date,"slotsId": slotsId, "workspaceId":workspaceId , "type" : type]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])

        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error:", error)
                return
            }
            do {
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
            } catch {
                print("error:", error)
            }
        }
        task.resume()
        
    }
}
