//
//  Nanoleaf.swift
//  SwiftWatchNanoleaf WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import Foundation

class Nanoleaf: ObservableObject {
    @Published var IP: String
    @Published var token: String
    
    init(IP: String, token: String) {
        self.IP = IP
        self.token = token
    }
    
    func getStatusAsync(completion: @escaping ((Data) -> Any)) {
        let url = URL(string: "http://" + self.IP + "/api/v1/" + self.token)!
        
        print("::: API ::: getStatusAsync()")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let status = data else { return }
            print("::: API ::: RETURNING ")
            _ = completion(status) // Promise resolve
        }
        
        task.resume()
    }
    
    func toggleLight(isOn: Bool) -> Void {
        let url = URL(string: "http://" + self.IP + "/api/v1/" + self.token + "/state")!
        
        print("::: API ::: toggleLight(" + String(isOn) + ")")
        
        let jsonObject: [String: Any] = [
            "on": [
                "value": isOn,
            ]
        ]
        
        let isValid = JSONSerialization.isValidJSONObject(jsonObject)
        print("isValid: " + String(isValid))
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonObject)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
    }
}



