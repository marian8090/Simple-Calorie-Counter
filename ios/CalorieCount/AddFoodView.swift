import SwiftUI

private let portions: [(label: String, multiplier: Double)] = [
    ("½", 0.5), ("¾", 0.75), ("1×", 1.0),
    ("1¼", 1.25), ("1½", 1.5), ("2×", 2.0),
]

struct AddFoodView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.dismiss) var dismiss

    @State private var searchText = ""
    @State private var selectedCategory: String? = nil
    @State private var manualName = ""
    @State private var manualCalories = ""
    @State private var selectedFood: ReferenceFood? = nil
    @State private var portionIndex = 2   // default 1×
    @State private var tab = 0            // 0=reference, 1=personal meals, 2=manual

    var filteredFoods: [ReferenceFood] {
        referenceFoods.filter { food in
            let matchesCat = selectedCategory == nil || food.category == selectedCategory
            let matchesSearch = searchText.isEmpty
                || food.name.localizedCaseInsensitiveContains(searchText)
            return matchesCat && matchesSearch
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker("Source", selection: $tab) {
                    Text("Foods").tag(0)
                    Text("My Meals").tag(1)
                    Text("Manual").tag(2)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.vertical, 8)

                if tab == 0 { referenceFoodsTab }
                else if tab == 1 { mealsTab }
                else { manualTab }
            }
            .navigationTitle("Add Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            .sheet(item: $selectedFood) { food in
                PortionConfirmView(food: food) { name, cals, source in
                    state.addEntry(name: name, calories: cals, source: source)
                    dismiss()
                }
            }
        }
    }

    // MARK: Reference foods tab

    var referenceFoodsTab: some View {
        VStack(spacing: 0) {
            SearchBar(text: $searchText)
                .padding(.horizontal)
                .padding(.bottom, 6)

            categoryPills

            Divider()

            List(filteredFoods) { food in
                FoodRow(food: food) {
                    selectedFood = food
                }
            }
            .listStyle(.plain)
        }
    }

    var categoryPills: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                CategoryPill(title: "All", selected: selectedCategory == nil) {
                    selectedCategory = nil
                }
                ForEach(foodCategories, id: \.self) { cat in
                    CategoryPill(title: cat, selected: selectedCategory == cat) {
                        selectedCategory = (selectedCategory == cat) ? nil : cat
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
    }

    // MARK: Personal meals tab

    var mealsTab: some View {
        Group {
            if state.meals.isEmpty {
                VStack(spacing: 8) {
                    Spacer()
                    Text("No saved meals yet")
                        .foregroundStyle(.secondary)
                    Text("Save meals from the My Meals tab")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            } else {
                List(state.meals) { meal in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(meal.name).font(.body)
                            Text("\(meal.calories) kcal")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Add") {
                            state.addEntry(name: meal.name, calories: meal.calories, source: "personal meal")
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                    }
                }
                .listStyle(.plain)
            }
        }
    }

    // MARK: Manual tab

    var manualTab: some View {
        Form {
            Section {
                TextField("Food name", text: $manualName)
                TextField("Calories (kcal)", text: $manualCalories)
                    .keyboardType(.numberPad)
            }
            Section {
                Button("Add Entry") {
                    guard let cals = Int(manualCalories), !manualName.isEmpty else { return }
                    state.addEntry(name: manualName, calories: cals, source: "manual")
                    dismiss()
                }
                .disabled(manualName.isEmpty || Int(manualCalories) == nil)
            }
        }
    }
}

// MARK: - Sub-views

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
            TextField("Search foods…", text: $text)
                .autocorrectionDisabled()
            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CategoryPill: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(selected ? Color.blue : Color(.secondarySystemBackground))
                .foregroundStyle(selected ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

struct FoodRow: View {
    let food: ReferenceFood
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Text(food.emoji).font(.title3)
            VStack(alignment: .leading, spacing: 2) {
                Text(food.name).font(.body)
                Text("\(food.calories) kcal").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Button("Add", action: onTap)
                .buttonStyle(.borderedProminent)
                .controlSize(.small)
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}
