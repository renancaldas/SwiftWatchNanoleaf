//
//  ContentView.swift
//  SwiftWatchNanoleafControl WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import SwiftUI

private let nanoleaf = Nanoleaf()
private let prefix: String = "[ ContentView ] "

struct ContentView: View {
    @State private var isLoaded = false
        
    func onRender() -> Void {
        print(prefix + ":: onRender ContentView")
        nanoleaf.getStatusAsync() { (status) -> Void in
            print(prefix + String(data: status, encoding: .utf8)!) // Parsing data
            
            self.isLoaded.toggle()
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if (isLoaded) {
                HomeView()
            } else {
                SplashView()
            }
        }
        .padding(.all)
        .onAppear { self.onRender() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


