import SwiftUI

struct MainTabView: View {
    @StateObject private var state = AppState()

    var body: some View {
        TabView {
            TodayView()
                .tabItem { Label("Today", systemImage: "flame.fill") }

            MealsView()
                .tabItem { Label("My Meals", systemImage: "fork.knife") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .environmentObject(state)
    }
}
