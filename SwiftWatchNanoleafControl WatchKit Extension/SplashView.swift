//
//  SplashView.swift
//  SwiftWatchNanoleafControl WatchKit Extension
//
//  Created by Renan Caldas on 23/05/20.
//  Copyright © 2020 Renan Caldas. All rights reserved.
//

import SwiftUI

private let prefix: String = "[ SplashView ] "

struct SplashView: View {
    func onRender() -> Void {
        print(prefix + ":: onAppear SplashView")
    }
    
    var body: some View {
        Image("nanoleaf-icon")
        .resizable()
        .scaledToFit()
            .onAppear { self.onRender() }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
