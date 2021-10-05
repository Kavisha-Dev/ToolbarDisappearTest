//
//  ToolbarDisappearTestApp.swift
//  Shared
//
//  Created by Kavisha Sonaal on 04/10/21.
//

import SwiftUI

@main
struct ToolbarDisappearTestApp: App {
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                ContentView()
            }
            // https://developer.apple.com/forums/thread/667107?login=true
            // Without this, when the child page was shown and the parent page refreshed, the child page tollbar buttons got hanged and could not be tapped. In My Next Meal, they kinda vanished.
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
