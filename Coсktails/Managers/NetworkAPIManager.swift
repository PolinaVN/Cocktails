//
//  NetworkAPIManager.swift
//  Coсktails
//
//  Created by Polina on 30.03.2022.
//

import Foundation
import Alamofire

final class NetworkAPIManager {
    
    //MARK: - Private Properties
    private let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php"
    
    //MARK: - Public Methods
    func getCoсktailsResponse(completionHandler: @escaping (Result<Drinks, Error>) -> Void) {
        AF.request(urlString, method: .get, parameters: ["a": "Non_Alcoholic"]).responseJSON { response in

            guard let data = response.data else {return}
            do {
                let cocktailResponse = try JSONDecoder().decode(Drinks.self, from: data)
                completionHandler(.success(cocktailResponse))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
