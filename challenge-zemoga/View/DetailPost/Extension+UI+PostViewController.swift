//
//  PostViewController+extension-ui.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import Foundation
import PureLayout

extension PostViewController {
    
    func addElementsForView() {
        self.view.addSubview(labelTitle)
        self.view.addSubview(labelDescription)
        self.view.addSubview(separatorView)
        self.view.addSubview(userImage)
        self.view.addSubview(aboutUser)
    }
    
    func configureConstraints(){
        labelTitle.autoPinEdge(.top, to: .top, of: view, withOffset: 100)
        labelTitle.autoPinEdge(.leading, to: .leading, of: view, withOffset: 10)
        labelTitle.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -10)
        
        labelDescription.autoPinEdge(.top, to: .bottom, of: labelTitle, withOffset: 10)
        labelDescription.autoPinEdge(.leading, to: .leading, of: view, withOffset: 10)
        labelDescription.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -10)
        
        separatorView.autoSetDimension(.height, toSize: 2)
        separatorView.autoPinEdge(.top, to: .bottom, of: labelDescription, withOffset: 5)
        separatorView.autoPinEdge(.leading, to: .leading, of: view, withOffset: 35)
        separatorView.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -35)
                
        userImage.autoSetDimension(.height, toSize: 20)
        userImage.autoSetDimension(.width, toSize: 20)
        userImage.autoPinEdge(.top, to: .bottom, of: separatorView, withOffset: 10)
        userImage.autoPinEdge(.leading, to: .leading, of: view, withOffset: 10)
        
        aboutUser.autoPinEdge(.top, to: .bottom, of: separatorView, withOffset: 10)
        aboutUser.autoPinEdge(.leading, to: .trailing, of: userImage, withOffset: 5)
        aboutUser.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -35)
    }
    
}
