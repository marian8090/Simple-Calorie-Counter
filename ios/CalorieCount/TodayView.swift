import SwiftUI

struct TodayView: View {
    @EnvironmentObject var state: AppState
    @State private var showAddFood = false

    var remaining: Int { state.dailyBudget - state.todayTotal }
    var progress: Double { min(Double(state.todayTotal) / Double(state.dailyBudget), 1.0) }
    var overBudget: Bool { state.todayTotal > state.dailyBudget }

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(spacing: 12) {
                        ProgressView(value: progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: overBudget ? .red : .blue))
                            .scaleEffect(x: 1, y: 2, anchor: .center)

                        HStack {
                            StatPill(label: "Eaten", value: "\(state.todayTotal) kcal", color: .blue)
                            Spacer()
                            StatPill(
                                label: overBudget ? "Over by" : "Remaining",
                                value: "\(abs(remaining)) kcal",
                                color: overBudget ? .red : .green
                            )
                            Spacer()
                            StatPill(label: "Budget", value: "\(state.dailyBudget) kcal", color: .secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Today's entries") {
                    if state.todayEntries.isEmpty {
                        Text("No entries yet — tap + to add food")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                    } else {
                        ForEach(state.todayEntries) { entry in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(entry.name).font(.body)
                                    Text(entry.time).font(.caption).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text("\(entry.calories) kcal")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.blue)
                            }
                        }
                        .onDelete { offsets in
                            let ids = offsets.map { state.todayEntries[$0].id }
                            ids.forEach { state.deleteEntry(id: $0) }
                        }
                    }
                }
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddFood = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddFood) {
                AddFoodView()
                    .environmentObject(state)
            }
        }
    }
}

struct StatPill: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(color)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }
}
