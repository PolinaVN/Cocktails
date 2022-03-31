//
//  HomePresenter.swift
//  Coсktails
//
//  Created by Polina on 30.03.2022.
//

import Foundation

protocol HomeView: AnyObject {
    func reloadCollectionView()
}

final class HomePresenter {
    
    //MARK: - Public Properties
    var cocktails: Drinks?
    
    //MARK: - Private Properties
    private weak var view: HomeView?
    private var networkAPIManager = NetworkAPIManager()
    
    //MARK: - Lifecycle Methods
    init(view: HomeView) {
        self.view = view
        fetchCoсktails()
    }
    

    //MARK: - Private Methods
    private func fetchCoсktails() {
        networkAPIManager.getCoсktailsResponse { [weak self] result in
            switch result {
            case .success(let cocktailsObject):
                self?.cocktails = cocktailsObject
                DispatchQueue.main.async {
                    self?.view?.reloadCollectionView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
