import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var state: AppState
    @State private var budgetText = ""
    @FocusState private var budgetFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section("Daily calorie budget") {
                    HStack {
                        TextField("Budget", text: $budgetText)
                            .keyboardType(.numberPad)
                            .focused($budgetFocused)
                            .onAppear { budgetText = "\(state.dailyBudget)" }
                        Text("kcal").foregroundStyle(.secondary)
                    }
                    Button("Save") {
                        if let val = Int(budgetText) {
                            state.dailyBudget = val
                        }
                        budgetFocused = false
                    }
                    .disabled(Int(budgetText) == nil)
                }

                Section("Data") {
                    Button("Clear today's entries", role: .destructive) {
                        let today = {
                            let f = DateFormatter()
                            f.dateFormat = "yyyy-MM-dd"
                            return f.string(from: Date())
                        }()
                        state.entries.removeAll { $0.date == today }
                    }
                }

                Section("About") {
                    LabeledContent("Version", value: "1.0")
                    LabeledContent("App", value: "CalorieCount")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
