//
//  MenuListCoordinator.swift
//  MiniProject
//
//  Created by hendra on 05/12/24.
//

import Combine
import UIKit

public final class MenuListCoordinator {
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    private func makeMenuListViewController() -> MenuListViewController {
        let menuService = MenuServicesImpl()
        let repository = makeMenuListRepository(menuService: menuService)
        let useCase = makeMenuListUseCase(
            repository: repository
        )
        let viewModel = makeMenuListViewModel(
            useCase: useCase
        )
        let viewController = MenuListViewController.create(
            with: viewModel
        )
        return viewController
    }
    
    private func makeMenuListViewModel(
        useCase: MenuListUseCase
    ) -> MenuListViewModel {
        return MenuListViewModel(
            coordinator: self,
            useCase: useCase
        )
    }
    
    private func makeMenuListUseCase(
        repository: MenuListRepository
    ) -> MenuListUseCase {
        return MenuListUseCaseImpl(repository: repository)
    }
    
    private func makeMenuListRepository(menuService : MenuServicesProtocol) -> MenuListRepository {
        return MenuListRepositoryImpl(menuService: menuService)
    }
    
    func route() {
        let vc = makeMenuListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func create() -> MenuListViewController {
        let vc = makeMenuListViewController()
        return vc
    }
}
