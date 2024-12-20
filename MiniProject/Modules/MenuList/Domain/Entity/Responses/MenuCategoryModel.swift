//
//  MenuListModel.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import Foundation

internal struct MenuModel: Codable, Equatable, Identifiable {
    var id: String = UUID().uuidString
    let idMeal: String
    let strMeal: String
    //    let strDrinkAlternate: String?
    //    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    //    let strTags: String?
    let strYoutube: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    //    let strSource: String?
    //    let strImageSource: String?
    //    let strCreativeCommonsConfirmed: String?
    //    let dateModified: String?
    //
    var ingredients: [String] {
        return [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ].compactMap { $0?.isEmpty == false ? $0 : nil }
    }
    //
    //    var measures: [String] {
    //        return [
    //            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
    //            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
    //            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
    //            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    //        ].compactMap { $0?.isEmpty == false ? $0 : nil }
    //    }
    
    //    init(idMeal: String, strMeal: String, strDrinkAlternate: String?, strCategory: String, strArea: String, strInstructions: String, strMealThumb: String, strTags: String?, strYoutube: String, strIngredient1: String?, strIngredient2: String?, strIngredient3: String?, strIngredient4: String?, strIngredient5: String?, strIngredient6: String?, strIngredient7: String?, strIngredient8: String?, strIngredient9: String?, strIngredient10: String?, strIngredient11: String?, strIngredient12: String?, strIngredient13: String?, strIngredient14: String?, strIngredient15: String?, strIngredient16: String?, strIngredient17: String?, strIngredient18: String?, strIngredient19: String?, strIngredient20: String?, strMeasure1: String?, strMeasure2: String?, strMeasure3: String?, strMeasure4: String?, strMeasure5: String?, strMeasure6: String?, strMeasure7: String?, strMeasure8: String?, strMeasure9: String?, strMeasure10: String?, strMeasure11: String?, strMeasure12: String?, strMeasure13: String?, strMeasure14: String?, strMeasure15: String?, strMeasure16: String?, strMeasure17: String?, strMeasure18: String?, strMeasure19: String?, strMeasure20: String?, strSource: String?, strImageSource: String?, strCreativeCommonsConfirmed: String?, dateModified: String?) {
    //        self.idMeal = idMeal
    //        self.strMeal = strMeal
    //        self.strDrinkAlternate = strDrinkAlternate
    //        self.strCategory = strCategory
    //        self.strArea = strArea
    //        self.strInstructions = strInstructions
    //        self.strMealThumb = strMealThumb
    //        self.strTags = strTags
    //        self.strYoutube = strYoutube
    //        self.strIngredient1 = strIngredient1
    //        self.strIngredient2 = strIngredient2
    //        self.strIngredient3 = strIngredient3
    //        self.strIngredient4 = strIngredient4
    //        self.strIngredient5 = strIngredient5
    //        self.strIngredient6 = strIngredient6
    //        self.strIngredient7 = strIngredient7
    //        self.strIngredient8 = strIngredient8
    //        self.strIngredient9 = strIngredient9
    //        self.strIngredient10 = strIngredient10
    //        self.strIngredient11 = strIngredient11
    //        self.strIngredient12 = strIngredient12
    //        self.strIngredient13 = strIngredient13
    //        self.strIngredient14 = strIngredient14
    //        self.strIngredient15 = strIngredient15
    //        self.strIngredient16 = strIngredient16
    //        self.strIngredient17 = strIngredient17
    //        self.strIngredient18 = strIngredient18
    //        self.strIngredient19 = strIngredient19
    //        self.strIngredient20 = strIngredient20
    //        self.strMeasure1 = strMeasure1
    //        self.strMeasure2 = strMeasure2
    //        self.strMeasure3 = strMeasure3
    //        self.strMeasure4 = strMeasure4
    //        self.strMeasure5 = strMeasure5
    //        self.strMeasure6 = strMeasure6
    //        self.strMeasure7 = strMeasure7
    //        self.strMeasure8 = strMeasure8
    //        self.strMeasure9 = strMeasure9
    //        self.strMeasure10 = strMeasure10
    //        self.strMeasure11 = strMeasure11
    //        self.strMeasure12 = strMeasure12
    //        self.strMeasure13 = strMeasure13
    //        self.strMeasure14 = strMeasure14
    //        self.strMeasure15 = strMeasure15
    //        self.strMeasure16 = strMeasure16
    //        self.strMeasure17 = strMeasure17
    //        self.strMeasure18 = strMeasure18
    //        self.strMeasure19 = strMeasure19
    //        self.strMeasure20 = strMeasure20
    //        self.strSource = strSource
    //        self.strImageSource = strImageSource
    //        self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
    //        self.dateModified = dateModified
    //    }
    
    init(idMeal: String, strMeal: String, strArea: String, strInstructions: String, strMealThumb: String, strYoutube: String, strIngredient1: String?, strIngredient2: String?, strIngredient3: String?, strIngredient4: String?, strIngredient5: String?, strIngredient6: String?, strIngredient7: String?, strIngredient8: String?, strIngredient9: String?, strIngredient10: String?, strIngredient11: String?, strIngredient12: String?, strIngredient13: String?, strIngredient14: String?, strIngredient15: String?, strIngredient16: String?, strIngredient17: String?, strIngredient18: String?, strIngredient19: String?, strIngredient20: String?, strMeasure1: String?, strMeasure2: String?, strMeasure3: String?, strMeasure4: String?, strMeasure5: String?, strMeasure6: String?, strMeasure7: String?, strMeasure8: String?, strMeasure9: String?, strMeasure10: String?, strMeasure11: String?, strMeasure12: String?, strMeasure13: String?, strMeasure14: String?, strMeasure15: String?, strMeasure16: String?, strMeasure17: String?, strMeasure18: String?, strMeasure19: String?, strMeasure20: String?) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strMealThumb = strMealThumb
        self.strYoutube = strYoutube
        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20
    }
}
