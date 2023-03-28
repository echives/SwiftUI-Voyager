//
//  ContentView.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2021/8/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    NavigationLink {
                        JSBridgeView()
                            .navigationTitle("JSBridge")
                    } label: {
                        Text("JSBridge")
                    }

                    NavigationLink {
                        NavigationHomeView()
                            .navigationTitle("Navigation")
                    } label: {
                        Text("Navigation")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all)
            }.navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
