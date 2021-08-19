//
//  TextAlignment.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2021/8/19.
//

import SwiftUI

struct TextAlignment: View {
    var body: some View {
        VStack(spacing: 20) {
            // firstTextBaseline
            HStack(alignment: .firstTextBaseline) {
                Text("床前明月光")
                    .font(.caption)
                    .frame(width: 50)
                    .background(Color.orange)

                Text("疑是地上霜")
                    .font(.body)
                    .frame(width: 50)
                    .background(Color.green)

                Text("举头望明月")
                    .font(.largeTitle)
                    .frame(width: 50)
                    .background(Color.blue)
            }
            .border(Color.gray)

            // lastTextBaseline
            HStack(alignment: .lastTextBaseline) {
                Text("床前明月光")
                    .font(.caption)
                    .frame(width: 50)
                    .background(Color.orange)

                Text("疑是地上霜")
                    .font(.body)
                    .frame(width: 50)
                    .background(Color.green)

                Text("举头望明月")
                    .font(.largeTitle)
                    .frame(width: 50)
                    .background(Color.blue)
            }
            .border(Color.gray)

            // 虽然对齐方式一致，但是获取不同对齐方式的偏移值
            HStack(alignment: .lastTextBaseline) {
                Text("床前明月光")
                    .font(.caption)
                    .frame(width: 50)
                    .background(Color.orange)

                Text("疑是地上霜")
                    .font(.body)
                    .frame(width: 50)
                    .background(Color.green)

                Text("举头望明月")
                    .font(.largeTitle)
                    .alignmentGuide(.lastTextBaseline, computeValue: { (d) -> CGFloat in
                        d[.firstTextBaseline]
                    })
                    .frame(width: 50)
                    .background(Color.blue)
            }
            .border(Color.gray)
        }

        // 其他view对baseline对齐方式的响应：bottom对齐
        HStack(alignment: .firstTextBaseline) {
            Text("床前明月光")
                .font(.caption)
                .frame(width: 50)
                .background(Color.orange)

            RoundedRectangle(cornerRadius: 3)
                .foregroundColor(.green)
                .frame(width: 50, height: 40)

            Text("疑是地上霜")
                .font(.body)
                .frame(width: 50)
                .background(Color.green)

            Text("举头望明月")
                .font(.largeTitle)
                .alignmentGuide(.firstTextBaseline, computeValue: { (d) -> CGFloat in
                    return 0
                })
                .frame(width: 50)
                .background(Color.blue)
        }
        .border(Color.gray)
    }
}

struct TextAlignment_Previews: PreviewProvider {
    static var previews: some View {
        TextAlignment()
    }
}
