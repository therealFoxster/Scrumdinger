//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-31.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        ZStack { // Views are overlayed back to front.
            RoundedRectangle(cornerRadius: 6)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                .padding(6)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .buttercup)
    }
}
