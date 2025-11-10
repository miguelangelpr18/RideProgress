import SwiftUI

struct ContentView: View {
    @StateObject private var yearSummaryCoordinator = YearSummaryCoordinator()
    @State private var isPresentingYearSummary = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "globe")
                    .font(.system(size: 64))
                    .foregroundStyle(.tint)

                Text("NovaRide")
                    .font(.largeTitle)
                    .bold()

                Text("Mapa y resumen del progreso vendrán aquí.")
                    .foregroundStyle(.secondary)

                Spacer()

                Button("Ver Resumen") {
                    isPresentingYearSummary = true
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Home")
        }
        .fullScreenCover(isPresented: $isPresentingYearSummary) {
            yearSummaryCoordinator.makeView()
        }
    }
}

#Preview {
    ContentView()
}
