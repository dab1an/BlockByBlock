import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // 1) CALENDAR
            CalendarScreen()
                .tabItem { Label("Calendar", systemImage: "calendar") }

            // 2) HABITS
            DashboardScreen()
                .tabItem { Label("Habits", systemImage: "plus") }

            // 3) SETTINGS
            SettingsScreen()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}

#Preview { ContentView() }

// placeholders so project can build
struct DashboardScreen: View {
    var body: some View {
        NavigationView {
            Text("Habits placeholder")
                .navigationTitle("Habits")
        }
    }
}

struct SettingsScreen: View {
    var body: some View {
        NavigationView {
            Text("Settings placeholder")
                .navigationTitle("Settings")
        }
    }
}
