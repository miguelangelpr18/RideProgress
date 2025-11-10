//
//  YearSummaryCoordinator.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import SwiftUI

@MainActor
final class YearSummaryCoordinator {
    private let service: YearSummaryService
    private let renderer: YearSummaryRenderer

    init(service: YearSummaryService, renderer: YearSummaryRenderer) {
        self.service = service
        self.renderer = renderer
    }

    convenience init() {
        self.init(service: YearSummaryServiceImpl(), renderer: YearSummaryRendererImpl())
    }

    func makeView() -> YearSummaryView {
        YearSummaryView(service: service, renderer: renderer)
    }
}

