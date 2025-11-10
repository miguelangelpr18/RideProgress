//
//  YearSummaryService.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import Foundation

protocol YearSummaryService {
    func fetchSummary(for year: Int) async throws -> YearSummary
}

final class YearSummaryServiceImpl: YearSummaryService {
    func fetchSummary(for year: Int) async throws -> YearSummary {
        // TODO(Fase 2): Reemplazar con implementación real usando datos de Strava.
        let fakeDate = Calendar.current.date(from: DateComponents(year: year, month: 6, day: 15)) ?? Date()

        let highlight = YearHighlight(
            title: "Ride around the bay",
            date: fakeDate,
            distanceKm: 180.0,
            movingMinutes: 420
        )

        return YearSummary(
            year: year,
            totalKm: 5280.0,
            totalMovingMinutes: 15200,
            totalElevationGain: 64000.0,
            activityCount: 213,
            longestActivity: highlight,
            mostActiveDay: highlight,
            countryHint: "Spain",
            activeDays: 180,
            longestStreakDays: 25
        )
    }
}

