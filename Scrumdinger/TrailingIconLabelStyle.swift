//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-29.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    // Called for every Label in a view hierachy with this LabelStyle applied.
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self {
        Self()
    }
}
