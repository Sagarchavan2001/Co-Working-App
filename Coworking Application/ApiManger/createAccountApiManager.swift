//
//  createAccountApiManager.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
class createAccountApiManager{
    static let shared = createAccountApiManager()
    func api(email:String,name : String){
        let url = URL(string: CreateAccountConstant.CreateAccount.CreateAccountUrl)!
        let jsonDict = ["email": email, "name": name]
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
