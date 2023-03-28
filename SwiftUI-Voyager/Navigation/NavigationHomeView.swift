//
//  NavigationHomeView.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2023/3/28.
//

import SwiftUI

struct NavigationHomeView: View {
    enum Selection {
        case numberIncrement
        case empty
    }
    @State var selection: Selection = .numberIncrement
    var body: some View {
        NavigationSplitView {
            ScrollView {
                VStack {
                    Button("数字增加") {
                        selection = .numberIncrement
                    }
                    .font(.title)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selection == .numberIncrement ? Color.gray : Color.white)
                    .cornerRadius(20)
                    .padding()

                    Button("空页面") {
                        selection = .empty
                    }
                    .font(.title)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selection == .empty ? Color.gray : Color.white)
                    .cornerRadius(20)
                    .padding()
                }
            }
        } content: {
            VStack {
                if selection == .numberIncrement {
                    Text("数字增加")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                    Text("""
                    1.在首页点击数字push到数字页面
                    2.在数字页面通过path可以完成跳转首页、进入下一个，返回上一个
                    """)
                } else if selection == .empty {
                    Text("空页面")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                Spacer()
            }
        } detail: {
            if selection == .numberIncrement {
                NavigationNumberIncrement()
            }
        }
    }
}

struct NavigationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHomeView()
    }
}
