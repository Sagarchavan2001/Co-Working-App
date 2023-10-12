//
//  loginApiManager.swift
//  Coworking Application
//
//  Created by STC on 07/10/23.
//

import Foundation
class LoginApiManager{
    static let shared = LoginApiManager()
    func api(email:String,password : String){
        let url = URL(string: LoginConstant.LoginApi.LoginApiUrl)!
        let jsonDict = ["email": email, "password": password]
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
