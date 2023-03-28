//
//  NavigationChildView.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2023/3/28.
//

import SwiftUI

struct NavigationChildView: View {
    let number: Int
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            Button("返回首页") {
                path.removeLast(path.count)
            }
            .foregroundColor(Color.black)
            .font(.title)
            .frame(width: 200, height: 100)
            .background(Color.gray)

            Button("返回上一页") {
                path.removeLast()
            }
            .foregroundColor(Color.black)
            .frame(width: 200, height: 100)
            .background(Color.gray)
            .font(.title)

            Button("跳转到=>\(number+1)") {
                path.append(number + 1)
            }
            .foregroundColor(Color.black)
            .frame(width: 200, height: 100)
            .background(Color.gray)
            .font(.title)
        }
        .navigationTitle("\(number)")
    }
}

struct NavigationChildView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationChildView(number: 2, path: .init(get: { return NavigationPath() }, set: { _ in }))
    }
}
