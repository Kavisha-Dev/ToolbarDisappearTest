//
//  ContentView.swift
//  Shared
//
//  Created by Kavisha Sonaal on 04/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var evilObject = TimerStateObject()
    
    @StateObject var todayMealStore: TodayMealStore = TodayMealStore()
    
    @State var stopTimer = false
    
    var body: some View {
        
        //NavigationView {
            ZStack {
                Form {
                    ForEach(todayMealStore.todaysMeals) { item in
                        NavigationLink(destination: SampleView02(name: item.name), isActive: getBinding(item)) {
                            Text("ForEach item: Tap me : \(item.name)")
                                .foregroundColor(.green)
                        }
                        .padding()
                    }
                    
                    /*if todayMealStore.todaysMeals.count > 0 {
                        
                        NavigationLink(destination: SampleView01(name: todayMealStore.todaysMeals[0].name), isActive: getBinding(todayMealStore.todaysMeals[0])) {
                            Text("ForEach item: Tap me : \(todayMealStore.todaysMeals[0].name)")
                                .foregroundColor(.green)
                        }
                        .padding()
                        
                    }*/
                }
            }
            .navigationBarTitle("Today's Meal Plan", displayMode: .large)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: fetchTodaysMeals)
            .onChange(of: evilObject.changedNumber) { newValue in
                if !todayMealStore.todaysMeals.contains(where: {$0.stopTimer}) {
                    print("ContentView: onChange hit.")
                    fetchTodaysMeals()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        //self.showingActionSheet = true
                    }) {
                        HStack {
                            Image(systemName: "paintbrush")
                            Text("Generate Schedule")
                        }
                    }
                }
            }
        // Setting it here wont work
            //.navigationViewStyle(StackNavigationViewStyle())
        //}
    }
    
    //for iOS < 15
    func getBinding(_ item: TodayMealModel) -> Binding<Bool> {
        return Binding {
            item.stopTimer
        } set: { value in
            todayMealStore.todaysMeals[todayMealStore.todaysMeals.firstIndex(where: {$0.id == item.id}) ?? 0].stopTimer = value
        }
    }
    
    func fetchTodaysMeals() {
        todayMealStore.fetch()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SampleView02: View {
    
    @StateObject var mealDetailsStore: MealDetailsByCategoryStore = MealDetailsByCategoryStore()
    
    var name: String
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    if mealDetailsStore.mealModelList.count > 0 {
                        Section(header: Text("Okay Header")) {
                            Text(name)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Meal List", displayMode: .inline)
        .onAppear(perform: fetch)
        .toolbar {
            
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    //
                }){
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                
                Button(action: {
                    //self.showPicker.toggle()
                }) {
                    /*HStack {
                     Image(systemName: "doc.plaintext")
                     Text("Tool bar button")
                     .contentShape(Rectangle())
                     .foregroundColor(Color.accentColor)
                     }*/
                    
                    Image(systemName: "doc.plaintext")
                }
                
                Button(action: {
                    //
                }) {
                    HStack {
                     Image(systemName: "paintbrush")
                     Text("Generate Schedule")
                     }
                }
            }
        }
    }
    
    private func fetch() {
        mealDetailsStore.fetchMealDetailModel()
    }
    
}

struct SampleView01: View {
    
    var name: String
    
    var body: some View {
        VStack {
            Text(name)
        }
        .navigationBarTitle("Meal List", displayMode: .inline)
        .toolbar {
            
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    //
                }){
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                
                Button(action: {
                    //self.showPicker.toggle()
                }) {
                    /*HStack {
                        Image(systemName: "doc.plaintext")
                        Text("Tool bar button")
                            .contentShape(Rectangle())
                            .foregroundColor(Color.accentColor)
                    }*/
                    Image(systemName: "doc.plaintext")
                }
                
                Button(action: {
                    //self.showingActionSheet = true
                }) {
                    /*HStack {
                        Image(systemName: "paintbrush")
                        Text("Generate Schedule")
                    }*/
                    
                    Image(systemName: "paintbrush")
                }
            }
        }
        //}
    }
    
}


class TimerStateObject: ObservableObject {
    
    var timer: Timer?
    var changedNumber: Int = 0
    
    @Published var number: Int = 0
    
    init() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in
            if Int.random(in: 1...3) == 1 {
                let num = Int.random(in: 100...500)
                self.number = num
                self.changedNumber = self.number
                //self.objectWillChange.send()
                
                print("*********** Timer invoked **************** ")
            }
        }
    }
}


class TodayMealStore: ObservableObject {
    
    @Published var todaysMeals: [TodayMealModel] = []
    
    func fetch() {
        var todayList:[TodayMealModel] = []
        
        let number1 = Int.random(in: 100...500)
        let number2 = Int.random(in: 100...500)
        
        let m1 = TodayMealModel(mealId: UUID.init(), name: "Meal Data - \(number1)")
        todayList.append(m1)
        
        let m2 = TodayMealModel(mealId: UUID.init(), name: "Meal Data -  \(number2)")
        todayList.append(m2)
        
        self.todaysMeals = todayList
        print("TodayMealStore fetch invoked!")
        
    }
}

struct TodayMealModel: Identifiable {
    
    public var id: UUID = UUID()
    var mealId: UUID
    var name: String
    
    var stopTimer = false
}
