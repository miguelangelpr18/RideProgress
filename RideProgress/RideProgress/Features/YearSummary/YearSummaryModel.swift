//
//  YearSummaryModel.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import Foundation

struct YearSummary {
    let year: Int
    let totalKm: Double
    let totalMovingMinutes: Int
    let totalElevationGain: Double
    let activityCount: Int
    let longestActivity: YearHighlight?
    let mostActiveDay: YearHighlight?
    let countryHint: String?
    let activeDays: Int?
    let longestStreakDays: Int?
}

struct YearHighlight {
    let title: String?
    let date: Date
    let distanceKm: Double?
    let movingMinutes: Int?
}

