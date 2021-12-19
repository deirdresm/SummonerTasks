//
//  View+Extension.swift
//  View+Extension
//
//  Created by Deirdre Saoirse Moen on 9/11/21.
//

import Foundation
import SwiftUI

struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct HeightKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func measureWidth(_ f: @escaping (CGFloat) -> ()) -> some View {
        overlay(GeometryReader { proxy in
            Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
        }
        .onPreferenceChange(WidthKey.self, perform: f))
    }
    func measureHeight(_ f: @escaping (CGFloat) -> ()) -> some View {
        overlay(GeometryReader { proxy in
            Color.clear.preference(key: HeightKey.self, value: proxy.size.height)
        }
        .onPreferenceChange(HeightKey.self, perform: f))
    }
}
