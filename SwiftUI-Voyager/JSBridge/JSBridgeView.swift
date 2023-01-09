//
//  JSBridgeView.swift
//  SwiftUI-Voyager
//
//  Created by echives on 2023/1/8.
//

import SwiftUI
import WebKit

private class Utils {
    static func generateJSFunction(callback: String, error: Int?, params: [String: Any]) -> String? {
        guard
            let jsonData = try? JSONSerialization.data(withJSONObject: params),
            let jsonString = String(data: jsonData, encoding: .utf8)
        else { return nil }

        return "\(callback)({ err: \(error ?? 0), data: '\(jsonString)' })"
    }
}

private class HelloWorldMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        guard let params = message.body as? [String: Any] else { return }
        print(params)
    }
}

private class CalculationMessageHandler: NSObject, WKScriptMessageHandler {
    weak var webView: WKWebView?

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        guard
            let params = message.body as? [String: Any],
            let numberA = params["numberA"] as? Int,
            let numberB = params["numberB"] as? Int,
            let callback = params["callback"] as? String
        else { return }
        print(callback)
        let result = numberA + numberB
        if let jsFunc = Utils.generateJSFunction(callback: callback, error: nil, params:    ["result": result]) {
            print(jsFunc)
            webView?.evaluateJavaScript(jsFunc, completionHandler: { _, error in
                print(error.debugDescription)
            })
        }
    }
}

private class SubtractionMessageHandler: NSObject, WKScriptMessageHandler {
    weak var webView: WKWebView?

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        guard
            let params = message.body as? [String: Any],
            let numberC = params["numberC"] as? Int,
            let numberD = params["numberD"] as? Int,
            let callback = params["callback"] as? String
        else { return }
        print(callback)
        let result = numberC - numberD
        if let jsFunc = Utils.generateJSFunction(callback: callback, error: nil, params: ["result": result]) {
            print(jsFunc)
            // 修改延时时间，查看bridge timeout的影响
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.webView?.evaluateJavaScript(jsFunc, completionHandler: { _, error in
                    print(error.debugDescription)
                })
            }
        }
    }
}

private struct SwiftUIWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView

    init() {
        let configuration = WKWebViewConfiguration()
        let helloworld = HelloWorldMessageHandler()
        let calculation = CalculationMessageHandler()
        let subtraction = SubtractionMessageHandler()
        configuration.userContentController.add(helloworld, name: "helloworld")
        configuration.userContentController.add(calculation, name: "calculateAddition")
        configuration.userContentController.add(subtraction, name: "calculationSubtraction")
        webView = WKWebView(frame: .zero, configuration: configuration)
        calculation.webView = webView
        subtraction.webView = webView
        webView.load(URLRequest(url: URL(string: "https://echives.github.io/learn_vue/#/jsbridge")!))
    }

    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct JSBridgeView: View {
    var body: some View {
        SwiftUIWebView()
    }
}

struct JSBridgeView_Previews: PreviewProvider {
    static var previews: some View {
        JSBridgeView()
    }
}
