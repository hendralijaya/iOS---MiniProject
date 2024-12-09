//
//  MiniProjectTests.swift
//  MiniProjectTests
//
//  Created by hendra on 02/12/24.
//

import Testing
@testable import MiniProject
import Foundation

struct MiniProjectTests {

    @Test
    func testGetMenuSuccess() async throws {
        // Arrange
        let mockNetworker = MockNetworker()
        let mockMenuResponse = MenuResponse(meals: [
            .init(
                idMeal: "53065",
                strMeal: "Sushi",
                strDrinkAlternate: nil,
                strCategory: "Seafood",
                strArea: "Japanese",
                strInstructions: """
                STEP 1
                TO MAKE SUSHI ROLLS: Pat out some rice. Lay a nori sheet on the mat, shiny-side down. Dip your hands in the vinegared water, then pat handfuls of rice on top in a 1cm thick layer, leaving the furthest edge from you clear.

                STEP 2
                Spread over some Japanese mayonnaise. Use a spoon to spread out a thin layer of mayonnaise down the middle of the rice.

                STEP 3
                Add the filling. Get your child to top the mayonnaise with a line of their favourite fillings – here we’ve used tuna and cucumber.

                STEP 4
                Roll it up. Lift the edge of the mat over the rice, applying a little pressure to keep everything in a tight roll.

                STEP 5
                Stick down the sides like a stamp. When you get to the edge without any rice, brush with a little water and continue to roll into a tight roll.

                STEP 6
                Wrap in cling film. Remove the mat and roll tightly in cling film before a grown-up cuts the sushi into thick slices, then unravel the cling film.

                STEP 7
                TO MAKE PRESSED SUSHI: Layer over some smoked salmon. Line a loaf tin with cling film, then place a thin layer of smoked salmon inside on top of the cling film.

                STEP 8
                Cover with rice and press down. Press about 3cm of rice over the fish, fold the cling film over and press down as much as you can, using another tin if you have one.

                STEP 9
                Tip it out like a sandcastle. Turn block of sushi onto a chopping board. Get a grown-up to cut into fingers, then remove the cling film.

                STEP 10
                TO MAKE SUSHI BALLS: Choose your topping. Get a small square of cling film and place a topping, like half a prawn or a small piece of smoked salmon, on it. Use damp hands to roll walnut-sized balls of rice and place on the topping.

                STEP 11
                Make into tight balls. Bring the corners of the cling film together and tighten into balls by twisting it up, then unwrap and serve.
                """,
                strMealThumb: "https://www.themealdb.com/images/media/meals/g046bb1663960946.jpg",
                strTags: nil,
                strYoutube: "https://www.youtube.com/watch?v=ub68OxEypaY",
                strIngredient1: "Sushi Rice",
                strIngredient2: "Rice wine",
                strIngredient3: "Caster Sugar",
                strIngredient4: "Mayonnaise",
                strIngredient5: "Rice wine",
                strIngredient6: "Soy Sauce",
                strIngredient7: "Cucumber",
                strIngredient8: "",
                strIngredient9: "",
                strIngredient10: "",
                strIngredient11: "",
                strIngredient12: "",
                strIngredient13: "",
                strIngredient14: "",
                strIngredient15: "",
                strIngredient16: "",
                strIngredient17: "",
                strIngredient18: "",
                strIngredient19: "",
                strIngredient20: "",
                strMeasure1: "300ml",
                strMeasure2: "100ml",
                strMeasure3: "2 tbs",
                strMeasure4: "3 tbs",
                strMeasure5: "1 tbs",
                strMeasure6: "1 tbs",
                strMeasure7: "1",
                strMeasure8: "",
                strMeasure9: "",
                strMeasure10: "",
                strMeasure11: "",
                strMeasure12: "",
                strMeasure13: "",
                strMeasure14: "",
                strMeasure15: "",
                strMeasure16: "",
                strMeasure17: "",
                strMeasure18: "",
                strMeasure19: "",
                strMeasure20: "",
                strSource: "https://www.bbcgoodfood.com/recipes/simple-sushi",
                strImageSource: nil,
                strCreativeCommonsConfirmed: nil,
                dateModified: nil
            )
        ])
        mockNetworker.mockResponse = mockMenuResponse

        let menuService = MenuServicesImpl(networker: mockNetworker)
        let mockEndpoint = NetworkFactory.getMenus(searchText: "")

        // Act
        let result = try await menuService.getMenu(endPoint: mockEndpoint)

        // Assert
        #expect(result.meals != nil, "The meals array should not be nil.")
        #expect(!result.meals.isEmpty, "The meals array should not be empty.")
        #expect(result.meals.contains { $0.strMeal == mockMenuResponse.meals.first?.strMeal } == true, "The meals should contain a meal named the same as in Mock Data.")
        
    }

    @Test
    func testGetMenuFailure() async throws {
        // Arrange
        let mockNetworker = MockNetworker()
        let mockError = NSError(domain: "TestError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        mockNetworker.mockError = mockError

        let menuService = MenuServicesImpl(networker: mockNetworker)
        let mockEndpoint = NetworkFactory.getMenus(searchText: "BUSET")

        // Act
        var thrownError: Error?
        do {
            _ = try await menuService.getMenu(endPoint: mockEndpoint)
        } catch {
            thrownError = error
        }

        // Assert
        #expect(thrownError != nil, "An error should have been thrown.")
        #expect((thrownError as? NSError)?.localizedDescription == mockError.localizedDescription, "The error should match the mock error.")
    }
}
