//
//  alignmentGuide.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2021/8/19.
//

import SwiftUI

struct TextAlignmentView: View {
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("offset")
                        .alignmentGuide(VerticalAlignment.center, computeValue: { _ in
                            return -0
                        })
                        .border(.gray)

                    Text("offset")
                        .alignmentGuide(VerticalAlignment.center, computeValue: { _ in
                            return -0
                        })
                        .border(.gray)
                }
                .border(Color.red)

                VStack {
                    Text("offset")
                        .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
                            return -40
                        })
                        .border(.gray)

                    Text("offset")
                        .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in
                            return 40
                        })
                        .border(.gray)
                }
                .border(Color.red)
            }
        }
    }
}

struct TextAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TextAlignmentView()
    }
}
