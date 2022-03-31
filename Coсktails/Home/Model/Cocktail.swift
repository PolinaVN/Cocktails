//
//  Cocktail.swift
//  Coсktails
//
//  Created by Polina on 30.03.2022.
//

import Foundation

class Drinks: Decodable {
    var drinks: [Cocktail]
}

class Cocktail: Decodable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
    var isSelected: Bool
    
    enum CodingKeys: String, CodingKey {
        case strDrink, strDrinkThumb, idDrink
    }
    

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.strDrink = try! container.decode(String.self, forKey: .strDrink)
        self.strDrinkThumb = try! container.decode(String.self, forKey: .strDrinkThumb)
        self.idDrink = try! container.decode(String.self, forKey: .idDrink)
        self.isSelected = false
    }
}
