//
//  Nanoleaf.swift
//  SwiftWatchNanoleafControl WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import Foundation

let IP: String = "192.168.0.119:16021"
let token: String = "RIuhkjxqsiyogaO5r05EZLOSJWRZtHjD"
let baseUrl: String = "http://" + IP + "/api/v1/" + token

func callMethod(method: String, completion: @escaping ((Data) -> Any)) {
    let url = URL(string: baseUrl + method)!
    
    print("::: API ::: request()")
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let response = data else { return }
        print("::: API ::: response ")
        _ = completion(response) // Promise resolve
    }
    
    task.resume()
}

class Nanoleaf: ObservableObject {
    
    func getStatusAsync(completion: @escaping ((Data) -> Any)) {
        callMethod(method: "") { (response) -> Void in
             _ = completion(response)
        }
    }
    
    func toggleLight(isOn: Bool) -> Void {
        let url = URL(string: "http://" + IP + "/api/v1/" + token + "/state")!
        
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
