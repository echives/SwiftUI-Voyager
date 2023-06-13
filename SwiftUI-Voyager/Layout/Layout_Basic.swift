//
//  Layout_Basic.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2023/6/1.
//

import SwiftUI

struct Layout_Basic: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello, World!")
                .background(.green)
                .frame(width: 200, height: 100)

            Text("Hello, World!")
                .frame(width: 200, height: 100)
                .background(.green)

            Text("Hello, World!")
                .background(.green)
                .frame(width: 200, height: 100)
                .border(.red)

            Text("idealSize of Text can ignore other constraints")
                .fixedSize()
                .border(.brown)

            Text("idealSize can be changed by frame modifier")
                .frame(idealWidth: 500)
                .border(.blue)
        }
        .frame(width: 300)
        .border(.red)
    }
}

struct Layout_Basic_Previews: PreviewProvider {
    static var previews: some View {
        Layout_Basic()
    }
}
