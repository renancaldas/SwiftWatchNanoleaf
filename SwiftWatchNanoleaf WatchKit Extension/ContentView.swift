//
//  ContentView.swift
//  SwiftWatchNanoleaf WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import SwiftUI

private let nanoleaf = Nanoleaf(
    IP: "192.168.0.119:16021",
    token: "RIuhkjxqsiyogaO5r05EZLOSJWRZtHjD"
)

class ViewModel: ObservableObject {
    var isToggled: Bool = false {
        didSet {
            print("isToggled didSet handler")
            nanoleaf.toggleLight(isOn: isToggled)
        }
    }
}

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            HStack {
                Text("Nanoleaf")
                    .font(.headline)
                    .fontWeight(.bold)
                    .fixedSize()
                
                Toggle("", isOn: $model.isToggled)
            }
            
            // Brighness

            
            Spacer()
            
            
            // GetStatus()
            Button(action: {
                print("Clicked getStatus()")
                nanoleaf.getStatusAsync() { (status) -> Void in
                    print(String(data: status, encoding: .utf8)!) // Parsing data
                }
            }) {
                Text("GetStatus()")
            }
        }
        .padding(.all)
        .border(/*@START_MENU_TOKEN@*/Color.gray/*@END_MENU_TOKEN@*/, width: 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
