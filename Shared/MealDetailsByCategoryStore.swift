//
//  A.swift
//  ToolbarDisappearTest
//
//  Created by Kavisha Sonaal on 05/10/21.
//

import Foundation

class MealDetailsByCategoryStore: ObservableObject {
    
    @Published
    var mealModelList: [MealModel] = []
    
    func fetchMealDetailModel() {
        
        var mealItems: [MealModel] = []
        
        let model = MealModel(mealId: UUID(), name: "Item1")
        mealItems.append(model)
        
        let model2 = MealModel(mealId: UUID(), name: "Item2")
        mealItems.append(model2)
        
        self.mealModelList = mealItems
    }
    
}


struct MealModel: Identifiable {
    
    var id: UUID = UUID()
    var mealId: UUID?
    
    var name: String = ""
    
}
