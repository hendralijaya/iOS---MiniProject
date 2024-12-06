//
//  MenuListUseCase.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import Foundation
import Combine

internal protocol MenuListUseCase {
    func fetch(searchText: String) -> AnyPublisher<[MenuModel], NetworkError>
}

internal final class MenuListUseCaseImpl: MenuListUseCase {
    private let repository: MenuListRepository
    
    init(repository: MenuListRepository) {
        self.repository = repository
    }
    
    func fetch(searchText: String) -> AnyPublisher<[MenuModel], NetworkError> {
        repository.fetch(searchText: searchText)
    }
}

