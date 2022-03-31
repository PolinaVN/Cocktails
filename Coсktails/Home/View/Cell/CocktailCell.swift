//
//  CocktailCell.swift
//  Coсktails
//
//  Created by Polina on 30.03.2022.
//

import UIKit
import SnapKit

final class CocktailCell: UICollectionViewCell {
    
    //MARK: - Visual Components
   private let cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    //MARK: - Public Properties
    static let customHeight: CGFloat = 30.0
    
    //MARK: - Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    // MARK: - Public Methods
    func configureCell(cocktail: Cocktail) {
        cocktailNameLabel.text = cocktail.strDrink
        cocktail.isSelected ? setGradient() : setupView()
    }
    
    // MARK: - Private Methods
    private func addLabel() {
        addSubview(cocktailNameLabel)
        cocktailNameLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupView() {
        backgroundColor = UIColor.lightGray
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10
        addLabel()
    }
    
    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0, 1]
        print(gradientLayer.frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.addSublayer(gradientLayer)
        addLabel()
    }
}
