//
//  YSHeroTemplate.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import SwiftUI

struct YSHeroTemplate: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            Text("Hero Template Placeholder")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .ignoresSafeArea()
        // TODO(Fase 4): Construir diseño final del hero del resumen.
    }
}

#Preview {
    YSHeroTemplate()
}

