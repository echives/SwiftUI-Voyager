//
//  AlignmentGuide.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2021/8/19.
//

import SwiftUI

// MARK: - 基本使用
struct AlignmentView: View {
    var body: some View {
        VStack {
            List {
                // 默认对齐方式为center，因此子View的对齐能够生效
                HStack {
                    Text("offset")
                        .border(.gray)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in
                            // 使用容器赋予的隐式值
                            d[VerticalAlignment.center]
                        })

                    Text("offset")
                        .border(.gray)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in
                            return -10
                        })
                }
                .border(Color.red)

                // 对齐方式与容器不同，则不会生效
                VStack(alignment: .leading) {
                    Text("leading")
                        .border(.gray)
                        .alignmentGuide(HorizontalAlignment.leading, computeValue: { _ in
                            return -20
                        })

                    Text("leading")
                        .border(.gray)
                        .alignmentGuide(HorizontalAlignment.leading, computeValue: { _ in
                            return 20
                        })

                    Text("trailing")
                        .border(.gray)
                        .alignmentGuide(HorizontalAlignment.trailing, computeValue: { _ in
                            return 20
                        })
                }
                .border(Color.red)

                // frame的对齐方式将子View看作整体
                HStack {
                    Text("offset")
                        .border(.gray)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in
                            0
                        })

                    Text("offset")
                        .border(.gray)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in
                            return -10
                        })
                }
                .frame(width: 200, height: 100, alignment: .bottom)
                .border(Color.red)
            }
        }
    }
}

// MARK: - 自定义对齐方式
// 返回高度作为水平偏移
extension HorizontalAlignment {
    private enum WeirdAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height
        }
    }

    static let weirdAlignment = HorizontalAlignment(WeirdAlignment.self)
}
// 返回三分之一高度作为垂直偏移
extension VerticalAlignment {
    private enum OneThird: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height / 3
        }
    }

    static let oneThird = VerticalAlignment(OneThird.self)
}

struct CustomAlignmentView: View {
    var body: some View {
        VStack {
            // 每个view都以自身高度作为向左偏移量
            VStack(alignment: .weirdAlignment) {
                Text("leading")
                    .border(.gray)

                Text("leading")
                    .frame(width: 50, height: 200)
                    .border(.gray)

                Text("trailing")
                    .border(.gray)
            }
            .border(Color.red)

            // 每个view都向上偏移三分之一自身高度
            HStack(alignment: .oneThird) {
                Text("oneThird")
                    .border(.gray)

                Text("oneThird")
                    .frame(width: 100, height: 200)
                    .border(.gray)

                Text("oneThird")
                    .border(.gray)
            }
            .border(Color.red)
        }
    }
}

struct Alignment_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentView()
        CustomAlignmentView()
    }
}
