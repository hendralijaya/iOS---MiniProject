//
//  MenuListViewModel.swift
//  MiniProject
//
//  Created by hendra on 06/12/24.
//

import Foundation
import Combine

final class MenuListViewModel {
    
    private let coordinator: MenuListCoordinator
    private let useCase: MenuListUseCase
    private var cancellables = Set<AnyCancellable>()
    let output = Output()
    
    private var item: [MenuModel] = []
    
    struct Input {
        let didLoad: AnyPublisher<Void, Never>
        let searchText: AnyPublisher<String, Never>
    }
    
    class Output {
        @Published var result: DataState<[MenuModel]> = .initiate
        
        var isDataEmpty: Bool {
            if case .success(let data) = result {
                return data.isEmpty
            }
            return false
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    init(
        coordinator: MenuListCoordinator,
        useCase: MenuListUseCase
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func bind(_ input: Input) {
        input.didLoad
            .flatMap { [weak self] _ -> AnyPublisher<Result<[MenuModel], Error>, Never> in
                guard let self = self else {
                    return Just(Result.failure(NSError(domain: "", code: -1, userInfo: nil))).eraseToAnyPublisher()
                }
                self.output.result = .loading
                return self.useCase.fetch(searchText: "")
                    .map { Result.success($0) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let models):
                    self?.item = models
                    self?.output.result = .success(data: models)
                case .failure(let error):
                    self?.output.result = .failed(reason: NetworkError.internetError(message: error.localizedDescription))
                }
            }
            .store(in: &cancellables)

        input.searchText
            .debounce(for: .milliseconds(2000), scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { [weak self] searchText -> AnyPublisher<Result<[MenuModel], Error>, Never> in
                guard let self = self else {
                    return Just(Result.failure(NSError(domain: "", code: -1, userInfo: nil))).eraseToAnyPublisher()
                }
                self.output.result = .loading
                return self.useCase.fetch(searchText: searchText)
                    .map { Result.success($0) }
                    .catch { Just(Result.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .success(let models):
                    self?.item = models
                    self?.output.result = .success(data: models)
                case .failure(let error):
                    self?.output.result = .failed(reason: NetworkError.internetError(message: error.localizedDescription))
                }
            }
            .store(in: &cancellables)
    }
}
