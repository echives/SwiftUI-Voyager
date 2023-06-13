//
//  Layout_CustomLayout.swift
//  SwiftUI-Voyager
//
//  Created by YH on 2023/6/5.
//

import SwiftUI

struct Layout_CustomLayout: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct CustomLayout: Layout {

    private var lines: [[CGSize]] = []

    func makeCache(subviews: Subviews) -> () {
        <#code#>
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        lines = []
        let containerWidth = proposal.width ?? 0
        let containerheight = proposal.height ?? 0
        var line = [CGSize]()
        var lineWidth: CGFloat = 0
        for view in subviews {
            let childProposalSize = view.sizeThatFits(proposal)
            if childProposalSize.width <= containerWidth - lineWidth {
                line.append(childProposalSize)
                lineWidth += childProposalSize.width
            } else {
                lines.append(line)
                line = [childProposalSize]
                lineWidth = childProposalSize.width
            }
        }

        let linesHeight = lines.compactMap({ line in
            line.max { size0, size1 in
                size0.height > size1.height
            }.map({ $0.height })
        })

        let height = linesHeight.reduce(into: 0) { partialResult, value in
            partialResult += value
        }

        return CGSize(width: containerWidth, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {

        }
    }


}

struct Layout_CustomLayout_Previews: PreviewProvider {
    static var previews: some View {
        Layout_CustomLayout()
    }
}
