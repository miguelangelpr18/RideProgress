//
//  YearSummaryView.swift
//  RideProgress
//
//  Created by Miguel Peña on 10/11/25.
//

import SwiftUI
import UIKit

struct YearSummaryView: View {
    enum ViewState {
        case idle
        case loading
        case error(String)
        case result(YearSummary, [UIImage])
    }

    enum YearSelection: String, CaseIterable, Identifiable {
        case thisYear = "Este año"
        case lastYear = "Año pasado"

        var id: String { rawValue }
    }

    private let service: YearSummaryService
    private let renderer: YearSummaryRenderer

    @Environment(\.dismiss) private var dismiss

    @State private var selectedYear: YearSelection = .thisYear
    @State private var state: ViewState = .idle
    @State private var isPresentingShareSheet = false
    @State private var shareImages: [UIImage] = []

    init(service: YearSummaryService, renderer: YearSummaryRenderer) {
        self.service = service
        self.renderer = renderer
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("Año", selection: $selectedYear) {
                    ForEach(YearSelection.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)

                generateSection

                previewSection

                shareButton

                Spacer()
            }
            .padding()
            .navigationTitle("Resumen del Año")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingShareSheet) {
            ActivityView(activityItems: shareImages)
        }
    }

    private var generateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Genera tu resumen con datos simulados.")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button(action: generateSummary) {
                Label("Generar", systemImage: "sparkles")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)
        }
    }

    private var previewSection: some View {
        Group {
            switch state {
            case .idle:
                Text("Selecciona un año y presiona Generar para ver una vista previa.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.top, 32)
            case .loading:
                ProgressView("Generando resumen…")
                    .progressViewStyle(.circular)
                    .padding(.vertical, 32)
            case .error(let message):
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(message)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 32)
            case .result(_, let images):
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .accessibilityLabel("Preview slide \(index + 1)")
                        }
                    }
                    .padding(.vertical, 12)
                }
            }
        }
    }

    private var shareButton: some View {
        Button(action: share) {
            Label("Compartir", systemImage: "square.and.arrow.up")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .disabled(generatedImages.isEmpty || isLoading)
    }

    private var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }

    private var generatedImages: [UIImage] {
        if case .result(_, let images) = state {
            return images
        }
        return []
    }

    @MainActor
    private func generateSummary() {
        state = .loading
        Task {
            do {
                let year = resolveYear(for: selectedYear)
                let summary = try await service.fetchSummary(for: year)
                let images = await MainActor.run {
                    renderer.renderSlides(summary: summary)
                }
                await MainActor.run {
                    state = .result(summary, images)
                }
            } catch {
                await MainActor.run {
                    state = .error("No pudimos generar el resumen. Intenta de nuevo.")
                }
            }
        }
    }

    @MainActor
    private func share() {
        guard !generatedImages.isEmpty else { return }
        shareImages = generatedImages
        isPresentingShareSheet = true
    }

    private func resolveYear(for selection: YearSelection) -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        switch selection {
        case .thisYear:
            return currentYear
        case .lastYear:
            return currentYear - 1
        }
    }
}

private struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    YearSummaryView(
        service: YearSummaryServiceImpl(),
        renderer: YearSummaryRendererImpl()
    )
}

