//
//  ContentView.swift
//  SwiftWatchNanoleafControl WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import SwiftUI

private let nanoleaf = Nanoleaf()

class ViewModel: ObservableObject {
    var isToggled: Bool = false {
        didSet {
            print("isToggled didSet handler")
            nanoleaf.toggleLight(isOn: isToggled)
        }
    }
    
    var sliderValue: Double = 0 {
        didSet {
            print("sliderValue: " + String(sliderValue))
            // nanoleaf.toggleLight(isOn: isToggled)
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

            
            Spacer()
            
            // Brighness
            Slider(value: $model.sliderValue, in: 0...10, step: 1)
                .accentColor(Color.green)
                .rotation3DEffect(Angle(degrees: 20), axis: (x: 1.0, y: 0.0, z: 0.0))
                
            // GetStatus()
            /*
            Button(action: {
                print("Clicked getStatus()")
                nanoleaf.getStatusAsync() { (status) -> Void in
                    print(String(data: status, encoding: .utf8)!) // Parsing data
                }
            }) {
                Text("GetStatus()")
            }
            */
        }
        .padding(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
