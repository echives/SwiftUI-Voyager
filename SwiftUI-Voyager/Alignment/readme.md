

[TOC]

# Alignment

## 对齐属性

View的对齐都要依靠容器进行，因为对齐这个概念描述的就是多个View之间的关系，单个View是无法反映对齐结果的。这里的容器就是指`VStack`、`HStack`、`ZStack`，对齐分为垂直对齐和水平对齐，我们需要设置HStack的垂直对齐方式以及VStack的水平对齐方式，对于ZStack则需要同时设置两种对齐方式。

![](https://pic1.zhimg.com/80/v2-317426617799007e91b838df0b140234_720w.jpg)

对齐的一些基本概念：

alignment属性的目的，其实就是获取到每个View在水平或者垂直方向上的**偏移量**，每个View的偏移量各不相同，最终通过每个View与其他View的偏移量差值，渲染出参差不齐或者某一边对齐的效果。

- Container Alignment：容器的对齐方式
  - 子View没有设置alignmentGuide，则使用该对齐方式。
  - 子View设置了不同于容器的alignmentGuide，则子View的对齐方式不生效。
  - 子View设置了相同的alignmentGuide，则根据guide中的闭包返回值进行偏移量。
- Alignment Guide：容器内的View需要保证对齐方式与容器默认对齐方式一致，否则不会生效，在此基础上可以通过闭包的方式调整偏移量。
- Implicit Alignment Value：隐式偏移量，子View没有设置显式偏移量时则获取容器设置的隐式值。
- Explicit Alignment Value：显式偏移量，即通过Alignment Guide设置的值。
- Frame Alignment：将容器内所有Views看作一个整体，对该整体的对齐方式。
- Text Alignment：控制多行文本的对齐方式。

## 默认对齐方式

HorizontalAlignment包含三个默认对齐方式：

```swift
extension HorizontalAlignment {
    public static let leading: HorizontalAlignment
    public static let center: HorizontalAlignment
    public static let trailing: HorizontalAlignment
}
```

VerticalAlignment包含五个默认对齐方式：

```swift
extension VerticalAlignment {
    public static let top: VerticalAlignment
    public static let center: VerticalAlignment
    public static let bottom: VerticalAlignment
    public static let firstTextBaseline: VerticalAlignment
    public static let lastTextBaseline: VerticalAlignment
}
```

两个Baseline是专门针对文本创建的，分别是以Text第一行的baseline和最后一行的baseline进行对齐，如果文本不是多行文本，则两个值的效果一样。

前面提到，对齐的最终目的都是获取到一个CGFloat类型的偏移量offset，水平对齐下，offset大于0则向左偏移，垂直对齐下，offset大于0则向上偏移。上述默认实现对于偏移量的计算如下：

- HorizontalAlignment：.leading值为0，.center值为width/2，.trailing值为width
- VerticalAlignment：.top值为0，.center值为height/2，.bottom值为height

举个例子，如果设置容器对齐方式为.bottom，且子View都没有设置alignmentGuide，此时每个子View都按照自身高度去偏移，最终的效果就是底部对齐。

## ViewDimensions

alignmentGuide方法的闭包参数接受一个类型为ViewDimensions的参数，ViewDimensions包含view的宽高，以及获取对齐值的下标操作符，结构如下：

```swift
public struct ViewDimensions {
    public var width: CGFloat { get } // The view's width
    public var height: CGFloat { get } // The view's height

    public subscript(guide: HorizontalAlignment) -> CGFloat { get }
    public subscript(guide: VerticalAlignment) -> CGFloat { get }
    public subscript(explicit guide: HorizontalAlignment) -> CGFloat? { get }
    public subscript(explicit guide: VerticalAlignment) -> CGFloat? { get }
}
```

ViewDimensions使用下标操作符访问属性分为显式和隐式两种：

```swift
d[.trailing] // 隐式
d[explicit: .trailing] // 显式
```

## 自定义对齐方式

以获取三分之一自身高度作为偏移量为例：

```swift
extension VerticalAlignment {
    private enum OneThird: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context.height / 3
        }
    }

    static let oneThird = VerticalAlignment(OneThird.self)
}
```

## 内容来源

- https://zhuanlan.zhihu.com/p/145821031
- https://www.answertopia.com/swiftui/swiftui-stack-alignment-and-alignment-guides/
