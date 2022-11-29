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
        self.view.addSubview(uiStackViewBody)
    }
    
    func buildStackUser() {
        uiStackViewUser.addArrangedSubview(userImage)
        uiStackViewUser.addArrangedSubview(aboutUser)
    }
    
    func buildStackBody() {
        uiStackViewBody.addArrangedSubview(uiStackViewUser)
        uiStackViewBody.addArrangedSubview(separatorView2)
        uiStackViewBody.addArrangedSubview(uiTableViewComments)
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
        
        uiStackViewBody.autoPinEdge(.top, to: .bottom, of: separatorView, withOffset: 10)
        uiStackViewBody.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: -5)
        uiStackViewBody.autoPinEdge(.leading, to: .leading, of: view, withOffset: 10)
        uiStackViewBody.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -10)
    
        separatorView2.autoSetDimension(.height, toSize: 2)
        separatorView2.autoPinEdge(.leading, to: .leading, of: view, withOffset: 35)
        separatorView2.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -35)

        uiTableViewComments.autoPinEdge(.top, to: .bottom, of: separatorView2)
        uiTableViewComments.autoPinEdge(.trailing, to: .trailing, of: uiStackViewBody)
        uiTableViewComments.autoPinEdge(.bottom, to: .bottom, of: uiStackViewBody)
        uiTableViewComments.autoPinEdge(.leading, to: .leading, of: uiStackViewBody)
        
        self.view.layoutIfNeeded()
    }
    
}
