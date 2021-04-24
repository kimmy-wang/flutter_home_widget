//
//  HomeWidget.swift
//  HomeWidget
//
//  Created by Ying Wang on 2021/4/24.
//

import WidgetKit
import SwiftUI

@main
struct HomeWidget: WidgetBundle {
    init() {
        WidgetCenter.shared.reloadAllTimelines()
    }

    @WidgetBundleBuilder
    var body: some Widget {
        ImageWidget()
        #if os(iOS)
        ImageUIWidget()
        #endif
    }
}

private let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
private let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue
        | CGImageByteOrderInfo.order32Big.rawValue)

typealias DrawCallback = (_ result: CGImage?) -> Void

func imageFromPixel(_ pixels: Data, _ width: Int, _ height: Int) -> CGImage? {
    guard width > 0 && height > 0 else { return nil }
    let bytesPerRow: Int = width * 4
    guard pixels.count == height * bytesPerRow else { return nil }

    guard let providerRef = CGDataProvider(data: pixels as NSData) else { return nil }
    return CGImage(
        width: width,
        height: height,
        bitsPerComponent: 8,
        bitsPerPixel: 32,
        bytesPerRow: bytesPerRow,
        space: rgbColorSpace,
        bitmapInfo: bitmapInfo,
        provider: providerRef,
        decode: nil,
        shouldInterpolate: false,
        intent: .defaultIntent
    )
}
