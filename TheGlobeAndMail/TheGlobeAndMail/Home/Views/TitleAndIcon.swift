//
//  TitleAndIcon.swift
//  TheGlobeAndMail
//
//  Created by Prasanth pc on 2024-10-23.
//

import SwiftUI

struct TitleAndIcon: View {
    let title: String
    let showTrailingIcon: Bool
    var body: some View {
        if showTrailingIcon {
            Group {
                let trailingIcon = Text("X")
                    .foregroundStyle(.red)
                let space = Text(" ")
                let title = Text(title)
                title + space + trailingIcon
            }
            .bold()
            .font(.title3)
        } else {
            Text(title)
                .bold()
                .font(.title3)
        }
    }
}

