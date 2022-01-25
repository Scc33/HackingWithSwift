//
//  ContentView.swift
//  Moonshot
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("Example")
                .frame(width: 300, height: 300)
                .clipped()
            Image("Example")
                .resizable()
                .frame(width: 300, height: 300)
            Image("Example")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
