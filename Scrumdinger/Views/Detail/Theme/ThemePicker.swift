//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2022-12-31.
//

import SwiftUI

struct ThemePicker: View {
    // Binding to theme structure defined in parent view.
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme) // Tag to differentiate subviews.
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle)) // Binding to hard-coded, immutable value (useful in previews/prototypes).
    }
}
