//
//  Extension+UI+ListPostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import Foundation
import UIKit

extension ListPostViewController {
    
    func addElementsToView() {
        self.view.addSubview(uiMainView)
        self.uiMainView.addSubview(uiTableView)
        self.uiMainView.addSubview(uiStackView)
    }
    
    func buildStackView() {
        uiStackView.addArrangedSubview(titleEmpty)
        uiStackView.addArrangedSubview(imageWarning)
    }
    
    func addElementBarRigth(iconName: String, actionName: Selector) {
        let viewFavorites = UIBarButtonItem(image: UIImage(systemName: iconName), style: .done, target: self, action: actionName)
        self.navigationItem.rightBarButtonItem = viewFavorites
    }
    
    func showShimmer() {
        self.view.showAnimatedGradientSkeleton()
        self.uiTableView.showAnimatedGradientSkeleton()
    }
    
    func configureConstraints() {
        // ui Main View
        uiMainView.autoPinEdge(.top, to: .top, of: view, withOffset: 99.0)
        uiMainView.autoPinEdge(.bottom, to: .bottom, of: view)
        uiMainView.autoPinEdge(.leading, to: .leading, of: view)
        uiMainView.autoPinEdge(.trailing, to: .trailing, of: view)

        // iu Table View
        uiTableView.autoPinEdge(.top, to: .top, of: uiMainView)
        uiTableView.autoPinEdge(.bottom, to: .bottom, of: uiMainView)
        uiTableView.autoPinEdge(.leading, to: .leading, of: uiMainView)
        uiTableView.autoPinEdge(.trailing, to: .trailing, of: uiMainView)
        
        // ui stack view
        uiStackView.autoAlignAxis(toSuperviewAxis: .vertical)
        uiStackView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        //ui imagen
        imageWarning.autoSetDimension(.width, toSize: 100)
        imageWarning.autoSetDimension(.height, toSize: 100)
        self.view.layoutIfNeeded()
    }
    
}
