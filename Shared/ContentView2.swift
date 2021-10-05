//
//  ContentView2.swift
//  ToolbarDisappearTest
//
//  Created by Kavisha Sonaal on 05/10/21.
//

import SwiftUI

struct ContentView2: View {
    @State var isFavorite = false
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: isFavorite ? "star.fill" : "star")
                NavigationLink(destination: DetailView(isFavorite: $isFavorite)) {
                    Text("Go")
                }
            }
            .navigationTitle("ContentView")
            .toolbar() {
                ToolbarItem(placement: .bottomBar) {
                    Text("This is my ContentView")
                }
            }
        }
    }
}


struct DetailView: View {
    @Binding var isFavorite: Bool
    var body: some View {
        Button("Tap me!") {
            isFavorite.toggle()
        }
        .navigationTitle("DetailView")
        .toolbar() {
            ToolbarItem(placement: .bottomBar) {
                Text("This is my DetailView")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: isFavorite ? "star.fill" : "star")
            }
        }
    }
}
