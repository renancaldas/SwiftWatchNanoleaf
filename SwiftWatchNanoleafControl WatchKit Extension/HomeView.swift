//
//  HomeView.swift
//  SwiftWatchNanoleafControl WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import SwiftUI

private let nanoleaf = Nanoleaf()
private let prefix: String = "[ HomeView ] "

class HomeViewModel: ObservableObject {
    var isToggled: Bool = false {
        didSet {
            print(prefix + "isToggled didSet handler")
            nanoleaf.toggleLight(isOn: isToggled)
        }
    }
    
    var sliderValue: Double = 0 {
        didSet {
            print(prefix + "sliderValue: " + String(sliderValue))
            nanoleaf.setBrightness(value: Int(sliderValue))
        }
    }
}

struct HomeView: View {
    @ObservedObject var model = HomeViewModel()

    func onRender() -> Void {
        print(prefix + ":: onRender HomeView")
    }
    
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
            Slider(value: $model.sliderValue, in: 0...100, step: 10)
                .accentColor(Color.green)
                .rotation3DEffect(Angle(degrees: 20), axis: (x: 1.0, y: 0.0, z: 0.0))
                
            // GetStatus()
            /*
            Button(action: {
                print(prefix + "Clicked getStatus()")
                nanoleaf.getStatusAsync() { (status) -> Void in
                    print(prefix + String(data: status, encoding: .utf8)!) // Parsing data
                }
            }) {
                Text("GetStatus()")
            }
            */
        }
        .padding(.all)
        .onAppear { self.onRender() }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
