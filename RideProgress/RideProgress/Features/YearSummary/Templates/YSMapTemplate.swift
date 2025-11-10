//
//  YSMapTemplate.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import SwiftUI

struct YSMapTemplate: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.15)
            VStack(spacing: 12) {
                Image(systemName: "globe.europe.africa.fill")
                    .font(.system(size: 64))
                Text("Map Template Placeholder")
                    .font(.title3)
            }
        }
        .ignoresSafeArea()
        // TODO(Fase 4): Integrar captura/mapa estilizado para story.
    }
}

#Preview {
    YSMapTemplate()
}

