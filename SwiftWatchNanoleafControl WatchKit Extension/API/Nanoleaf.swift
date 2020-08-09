//
//  Nanoleaf.swift
//  SwiftWatchNanoleafControl WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import Foundation

private let IP: String = "192.168.0.119:16021"
private let token: String = "RIuhkjxqsiyogaO5r05EZLOSJWRZtHjD"
private let baseUrl: String = "http://" + IP + "/api/v1/" + token
private let prefix: String = "[ Nanoleaf API ] "

func callMethod(method: String, completion: @escaping ((Data) -> Any)) {
    let url = URL(string: baseUrl + method)!
    print(prefix + "callMethod()")
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let response = data else { return }
        print(prefix + "callMethod() finished and returning response...")
        _ = completion(response) // Promise resolve
    }
    
    task.resume()
}

class Nanoleaf: ObservableObject {
    
    // getStatusAsync
    func getStatusAsync(completion: @escaping ((Data) -> Any)) {
        callMethod(method: "") { (response) -> Void in
             _ = completion(response)
        }
    }
    
    // toggleLight
    func toggleLight(isOn: Bool) {
        let url = URL(string: baseUrl + "/state")!
        
        print(prefix + "toggleLight(" + String(isOn) + ")")
        
        let jsonObject: [String: Any] = [
            "on": [
                "value": isOn,
            ]
        ]
        
        let isValid = JSONSerialization.isValidJSONObject(jsonObject)
        print(prefix + "isValid: " + String(isValid))
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonObject)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request)
        
        task.resume()
    }
    
    // setBrightness
    func setBrightness(value: Int) {
        let url = URL(string: baseUrl + "/state")!
        
        print(prefix + "setBrightness(" + String(value) + ")")
        
        let jsonObject: [String: Any] = [
            "brightness": [
                "value": value,
                "duration": 1,
            ]
        ]
        
        let isValid = JSONSerialization.isValidJSONObject(jsonObject)
        print(prefix + "isValid: " + String(isValid))
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonObject)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request)
        
        task.resume()
    }
}
