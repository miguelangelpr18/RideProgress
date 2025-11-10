//
//  YSActivityTemplate.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import SwiftUI

struct YSActivityTemplate: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Activity Template Placeholder")
                .font(.title2)
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.2))
        // TODO(Fase 4): Diseñar tarjeta de actividad destacada.
    }
}

#Preview {
    YSActivityTemplate()
}

