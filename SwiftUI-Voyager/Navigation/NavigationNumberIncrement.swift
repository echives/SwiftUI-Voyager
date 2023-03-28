//
//  NavigationNumberIncrement.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2023/3/28.
//

import SwiftUI

struct NavigationNumberIncrement: View {
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                ForEach(0..<100) { number in
                    Button("\(number)") {
                        path.append(number)
                    }
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                }
            }
            .navigationDestination(for: Int.self) { nextNumber in
                NavigationChildView(number: nextNumber, path: $path)
            }
            .navigationDestination(for: String.self) { nextNumber in
                if let nextNumber = Int(nextNumber) {
                    NavigationChildView(number: nextNumber, path: $path)
                }
            }
        }
    }
}

struct NavigationNumberIncrement_Previews: PreviewProvider {
    static var previews: some View {
        NavigationNumberIncrement()
    }
}
