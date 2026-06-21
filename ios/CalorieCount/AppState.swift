import Foundation
import Combine

class AppState: ObservableObject {
    @Published var entries: [FoodEntry] = [] {
        didSet { save() }
    }
    @Published var meals: [Meal] = [] {
        didSet { save() }
    }
    @Published var dailyBudget: Int = 2000 {
        didSet { save() }
    }

    private let storageKey = "calorieCountData"

    init() { load() }

    var todayEntries: [FoodEntry] {
        let today = isoToday()
        return entries.filter { $0.date == today }
    }

    var todayTotal: Int {
        todayEntries.reduce(0) { $0 + $1.calories }
    }

    func addEntry(name: String, calories: Int, source: String) {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let entry = FoodEntry(
            date: isoToday(),
            time: formatter.string(from: now),
            name: name,
            calories: calories,
            source: source
        )
        entries.append(entry)
    }

    func deleteEntry(id: UUID) {
        entries.removeAll { $0.id == id }
    }

    func saveMeal(name: String, calories: Int) {
        meals.append(Meal(name: name, calories: calories))
    }

    func deleteMeal(id: UUID) {
        meals.removeAll { $0.id == id }
    }

    private func isoToday() -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: Date())
    }

    private struct Payload: Codable {
        var dailyBudget: Int
        var meals: [Meal]
        var entries: [FoodEntry]
    }

    private func save() {
        let payload = Payload(dailyBudget: dailyBudget, meals: meals, entries: entries)
        if let data = try? JSONEncoder().encode(payload) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let payload = try? JSONDecoder().decode(Payload.self, from: data) else { return }
        dailyBudget = payload.dailyBudget
        meals = payload.meals
        entries = payload.entries
    }
}
