//
//  ViewController.swift
//  Coсktails
//
//  Created by Polina on 30.03.2022.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    //MARK: - Visual Components
    private var cocktailsCollectionView: UICollectionView!
    
    private let cocktailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.textAlignment = .center
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 2
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "Cocktail name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        return textField
    }()
    
    //MARK: - Private Properties
    private var presenter: HomePresenter?
    private let wildCellID = "CocktailName"
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = HomePresenter(view: self)
        setup()
    }
    
    //MARK: - Private Methods
    private func setup() {
        view.backgroundColor = .white
        createdCollectionView()
        createdCocktailTextField()
    }
    
    private func createdCollectionView() {
        let customLayout = CustomFlowLayout()
        customLayout.delegate = self
        cocktailsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: customLayout)
        cocktailsCollectionView.delegate = self
        cocktailsCollectionView.dataSource = self
        
        cocktailsCollectionView.isScrollEnabled = false
        cocktailsCollectionView.register(CocktailCell.self, forCellWithReuseIdentifier: wildCellID)
        
        view.addSubview(cocktailsCollectionView)
        cocktailsCollectionView.snp.makeConstraints {            $0.leading.trailing.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.top.equalTo(20)
            $0.height.equalTo(260)
        }
    }
    
    private func createdCocktailTextField() {
        view.addSubview(cocktailTextField)
        cocktailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(35)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-10)
            $0.bottom.equalTo(-150)
        }
    }
}

//MARK: - HomeView
extension HomeViewController: HomeView {
    func reloadCollectionView() {
        cocktailsCollectionView.reloadData()
    }
}

//MARK: - CustomLayoutDelegate
extension HomeViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, sizeForPillAtIndexPath indexPath: IndexPath) -> CGSize {
        if presenter?.cocktails?.drinks.isEmpty == false {
            let label = presenter?.cocktails?.drinks[indexPath.row].strDrink
            let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CocktailCell.customHeight)
            let calculatedSize = (label! as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0)], context: nil)
            return CGSize(width: calculatedSize.width + 40, height: CocktailCell.customHeight)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, insetsForItemsInSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemSpacingInSection section: Int) -> CGFloat {
        return 8
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.cocktails?.drinks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cocktailsCollectionView.dequeueReusableCell(withReuseIdentifier: wildCellID, for: indexPath) as? CocktailCell else {return UICollectionViewCell()}
        if presenter?.cocktails?.drinks.isEmpty == false {
            guard let cocktail = presenter?.cocktails?.drinks[indexPath.row] else {return UICollectionViewCell()}
            cell.configureCell(cocktail: cocktail)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.cocktails?.drinks[indexPath.row].isSelected.toggle()
        let indexesToRedraw = [indexPath]
        collectionView.reloadItems(at: indexesToRedraw)
    }
}
