//
//  MenuCategoryResponse.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//


import Foundation

struct MenuResponse: Codable, Equatable {
    let meals: [Menu]
    
    init(meals: [Menu]) {
        self.meals = meals
    }
    
    init() {
        self.meals = []
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meals = try container.decodeIfPresent([Menu].self, forKey: .meals) ?? []
    }
}
