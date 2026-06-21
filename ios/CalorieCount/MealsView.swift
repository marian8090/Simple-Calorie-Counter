import SwiftUI

struct MealsView: View {
    @EnvironmentObject var state: AppState
    @State private var showAddMeal = false
    @State private var newName = ""
    @State private var newCalories = ""

    var body: some View {
        NavigationView {
            List {
                if state.meals.isEmpty {
                    Text("No saved meals yet")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                } else {
                    ForEach(state.meals) { meal in
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(meal.name).font(.body)
                                Text("\(meal.calories) kcal")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Button {
                                state.addEntry(name: meal.name, calories: meal.calories, source: "personal meal")
                            } label: {
                                Label("Add", systemImage: "plus")
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.small)
                        }
                    }
                    .onDelete { offsets in
                        let ids = offsets.map { state.meals[$0].id }
                        ids.forEach { state.deleteMeal(id: $0) }
                    }
                }
            }
            .navigationTitle("My Meals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddMeal = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddMeal) {
                addMealSheet
            }
        }
    }

    var addMealSheet: some View {
        NavigationView {
            Form {
                Section("New meal") {
                    TextField("Meal name", text: $newName)
                    TextField("Calories (kcal)", text: $newCalories)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button("Save Meal") {
                        guard let cals = Int(newCalories), !newName.isEmpty else { return }
                        state.saveMeal(name: newName, calories: cals)
                        newName = ""
                        newCalories = ""
                        showAddMeal = false
                    }
                    .disabled(newName.isEmpty || Int(newCalories) == nil)
                }
            }
            .navigationTitle("New Meal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { showAddMeal = false }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
