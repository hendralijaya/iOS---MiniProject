//
//  MenuListRepository.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import Foundation
import Combine

internal protocol MenuListRepository {
    func fetch(searchText: String) -> AnyPublisher<[MenuModel], NetworkError>
}

internal final class MenuListRepositoryImpl: MenuListRepository {
    private let menuService: MenuServicesProtocol
    
    init(menuService: MenuServicesProtocol) {
        self.menuService = menuService
    }
    
    func fetch(searchText: String) -> AnyPublisher<[MenuModel], NetworkError> {
        return Future<[MenuModel], NetworkError> { [weak self] promise in
            guard let self = self else { return }
            
            Task {
                do {
                    let response = try await self.menuService.getMenu(endPoint: .getMenus(searchText: searchText))
                    promise(.success(response.meals.map { menu in
//                        MenuModel(idMeal: menu.idMeal, strMeal: menu.strMeal, strDrinkAlternate: menu.strDrinkAlternate, strCategory: menu.strCategory, strArea: menu.strArea, strInstructions: menu.strInstructions, strMealThumb: menu.strMealThumb, strTags: menu.strTags, strYoutube: menu.strYoutube, strIngredient1: menu.strIngredient1, strIngredient2: menu.strIngredient2, strIngredient3: menu.strIngredient3, strIngredient4: menu.strIngredient4, strIngredient5: menu.strIngredient5, strIngredient6: menu.strIngredient6, strIngredient7: menu.strIngredient7, strIngredient8: menu.strIngredient8, strIngredient9: menu.strIngredient9, strIngredient10: menu.strIngredient10, strIngredient11: menu.strIngredient11, strIngredient12: menu.strIngredient12, strIngredient13: menu.strIngredient13, strIngredient14: menu.strIngredient14, strIngredient15: menu.strIngredient15, strIngredient16: menu.strIngredient16, strIngredient17: menu.strIngredient17, strIngredient18: menu.strIngredient18, strIngredient19: menu.strIngredient19, strIngredient20: menu.strIngredient20, strMeasure1: menu.strMeasure1, strMeasure2: menu.strMeasure2, strMeasure3: menu.strMeasure3, strMeasure4: menu.strMeasure4, strMeasure5: menu.strMeasure5, strMeasure6: menu.strMeasure6, strMeasure7: menu.strMeasure7, strMeasure8: menu.strMeasure8, strMeasure9: menu.strMeasure9, strMeasure10: menu.strMeasure10, strMeasure11: menu.strMeasure11, strMeasure12: menu.strMeasure12, strMeasure13: menu.strMeasure13, strMeasure14: menu.strMeasure14, strMeasure15: menu.strMeasure15, strMeasure16: menu.strMeasure16, strMeasure17: menu.strMeasure17, strMeasure18: menu.strMeasure18, strMeasure19: menu.strMeasure19, strMeasure20: menu.strMeasure20, strSource: menu.strSource, strImageSource: menu.strImageSource, strCreativeCommonsConfirmed: menu.strCreativeCommonsConfirmed, dateModified: menu.dateModified)
                        MenuModel(idMeal: menu.idMeal, strMeal: menu.strMeal, strArea: menu.strArea, strMealThumb: menu.strMealThumb)
                    }))
                } catch let error as NetworkError {
                    promise(.failure(error))
                } catch {
                    promise(.failure(.internetError(message: "Internal Error")))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
