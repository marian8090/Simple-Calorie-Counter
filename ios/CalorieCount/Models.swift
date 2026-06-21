import Foundation

struct FoodEntry: Identifiable, Codable {
    var id: UUID = UUID()
    var date: String   // YYYY-MM-DD
    var time: String   // HH:mm
    var name: String
    var calories: Int
    var source: String // "manual", "personal meal", "reference food"
}

struct Meal: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var calories: Int
}

struct ReferenceFood: Identifiable {
    var id: UUID = UUID()
    var emoji: String
    var name: String
    var calories: Int   // per typical serving
    var category: String
}
