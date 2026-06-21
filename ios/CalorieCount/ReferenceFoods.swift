import Foundation

let referenceFoods: [ReferenceFood] = [
    // MARK: - Fast Food
    ReferenceFood(emoji: "🍔", name: "Cheeseburger",           calories: 550,  category: "Fast Food"),
    ReferenceFood(emoji: "🍔", name: "Big Mac",                calories: 550,  category: "Fast Food"),
    ReferenceFood(emoji: "🍟", name: "Medium Fries",           calories: 340,  category: "Fast Food"),
    ReferenceFood(emoji: "🍗", name: "Fried Chicken (2 pcs)",  calories: 490,  category: "Fast Food"),
    ReferenceFood(emoji: "🌭", name: "Hot Dog",                calories: 310,  category: "Fast Food"),
    ReferenceFood(emoji: "🥪", name: "Club Sandwich",          calories: 590,  category: "Fast Food"),
    ReferenceFood(emoji: "🌮", name: "Beef Taco",              calories: 210,  category: "Fast Food"),
    ReferenceFood(emoji: "🌯", name: "Chicken Burrito",        calories: 690,  category: "Fast Food"),
    ReferenceFood(emoji: "🍕", name: "Pepperoni Pizza slice",  calories: 285,  category: "Fast Food"),

    // MARK: - Breakfast
    ReferenceFood(emoji: "🍳", name: "Full English Breakfast", calories: 800,  category: "Breakfast"),
    ReferenceFood(emoji: "🥣", name: "Muesli with milk",       calories: 350,  category: "Breakfast"),
    ReferenceFood(emoji: "🥣", name: "Corn Flakes with milk",  calories: 260,  category: "Breakfast"),
    ReferenceFood(emoji: "🥞", name: "Pancakes (3, no syrup)", calories: 360,  category: "Breakfast"),
    ReferenceFood(emoji: "🥚", name: "Scrambled Eggs (2)",     calories: 210,  category: "Breakfast"),
    ReferenceFood(emoji: "🍞", name: "Toast with butter (2)",  calories: 200,  category: "Breakfast"),
    ReferenceFood(emoji: "🥐", name: "Croissant",              calories: 275,  category: "Breakfast"),
    ReferenceFood(emoji: "🧇", name: "Waffle with syrup",      calories: 410,  category: "Breakfast"),
    ReferenceFood(emoji: "🫐", name: "Greek Yogurt & Berries", calories: 190,  category: "Breakfast"),

    // MARK: - Popular Dishes
    ReferenceFood(emoji: "🐟", name: "Fish & Chips",           calories: 840,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🥩", name: "Steak & Fries",          calories: 900,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🍕", name: "Margherita Pizza (1/2)", calories: 570,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🍝", name: "Spaghetti Bolognese",    calories: 670,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🍛", name: "Chicken Tikka Masala",   calories: 580,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🍜", name: "Beef Ramen",             calories: 550,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🥗", name: "Caesar Salad",           calories: 360,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🫕", name: "Beef Stew",              calories: 490,  category: "Popular Dishes"),
    ReferenceFood(emoji: "🍱", name: "Sushi Set (8 pcs)",      calories: 380,  category: "Popular Dishes"),

    // MARK: - Ready Meals
    ReferenceFood(emoji: "📦", name: "Mac & Cheese (box)",     calories: 420,  category: "Ready Meals"),
    ReferenceFood(emoji: "📦", name: "Lasagne (ready meal)",   calories: 490,  category: "Ready Meals"),
    ReferenceFood(emoji: "📦", name: "Cottage Pie",            calories: 380,  category: "Ready Meals"),
    ReferenceFood(emoji: "📦", name: "Chicken Korma (ready)",  calories: 450,  category: "Ready Meals"),
    ReferenceFood(emoji: "📦", name: "Chicken Noodles",        calories: 380,  category: "Ready Meals"),
    ReferenceFood(emoji: "🥫", name: "Baked Beans on Toast",   calories: 290,  category: "Ready Meals"),
    ReferenceFood(emoji: "🍲", name: "Tomato Soup",            calories: 130,  category: "Ready Meals"),

    // MARK: - Drinks
    ReferenceFood(emoji: "🍺", name: "Lager (pint)",           calories: 240,  category: "Drinks"),
    ReferenceFood(emoji: "🍺", name: "Ale (pint)",             calories: 210,  category: "Drinks"),
    ReferenceFood(emoji: "🍷", name: "Red Wine (175 ml)",      calories: 160,  category: "Drinks"),
    ReferenceFood(emoji: "🍷", name: "White Wine (175 ml)",    calories: 150,  category: "Drinks"),
    ReferenceFood(emoji: "🥂", name: "Prosecco (125 ml)",      calories: 90,   category: "Drinks"),
    ReferenceFood(emoji: "🥃", name: "Whiskey (25 ml)",        calories: 55,   category: "Drinks"),
    ReferenceFood(emoji: "🍸", name: "Gin & Tonic",            calories: 120,  category: "Drinks"),
    ReferenceFood(emoji: "🧃", name: "Orange Juice (250 ml)",  calories: 110,  category: "Drinks"),
    ReferenceFood(emoji: "🥛", name: "Whole Milk (250 ml)",    calories: 160,  category: "Drinks"),
    ReferenceFood(emoji: "☕", name: "Latte (medium)",         calories: 190,  category: "Drinks"),
    ReferenceFood(emoji: "🧋", name: "Bubble Tea",             calories: 330,  category: "Drinks"),
    ReferenceFood(emoji: "🥤", name: "Cola (330 ml)",          calories: 140,  category: "Drinks"),

    // MARK: - Snacks
    ReferenceFood(emoji: "🍫", name: "Chocolate Bar (50 g)",   calories: 260,  category: "Snacks"),
    ReferenceFood(emoji: "🍪", name: "Digestive Biscuits (2)", calories: 140,  category: "Snacks"),
    ReferenceFood(emoji: "🥜", name: "Mixed Nuts (30 g)",      calories: 180,  category: "Snacks"),
    ReferenceFood(emoji: "🍿", name: "Popcorn (cinema bag)",   calories: 400,  category: "Snacks"),
    ReferenceFood(emoji: "🍎", name: "Apple",                  calories: 80,   category: "Snacks"),
    ReferenceFood(emoji: "🍌", name: "Banana",                 calories: 105,  category: "Snacks"),
    ReferenceFood(emoji: "🧀", name: "Cheddar Cheese (30 g)",  calories: 120,  category: "Snacks"),
    ReferenceFood(emoji: "🥚", name: "Hard-boiled Egg",        calories: 70,   category: "Snacks"),
]

let foodCategories: [String] = {
    var seen = Set<String>()
    var cats: [String] = []
    for f in referenceFoods where !seen.contains(f.category) {
        seen.insert(f.category)
        cats.append(f.category)
    }
    return cats
}()
