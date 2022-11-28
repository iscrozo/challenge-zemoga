//
//  PostView.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import PureLayout

class PostView: UIView {
    
    weak var uiPostView: UIView!
    let spaceVerticalViews: CGFloat = 10.0, spaceHorizontalViews: CGFloat = 20.0
    
    required init() {
        super.init(frame: .zero)
        createElementView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostView {
    private func createElementView() {
        let viewPost = UIView(frame: .zero)
        viewPost.backgroundColor = .blue
        self.uiPostView = viewPost
        self.addSubview(uiPostView)
        
        self.uiPostView.autoPinEdge(toSuperviewEdge: .top)
        self.uiPostView.autoPinEdge(toSuperviewEdge: .leading)
        self.uiPostView.autoPinEdge(toSuperviewEdge: .trailing)
        self.uiPostView.autoPinEdge(toSuperviewEdge: .bottom)
    }
}


//extension ListPostView {
//    override func updateConstraints() {
//        self.autoPinEdge(toSuperviewEdge: .top)
//        self.autoPinEdge(toSuperviewEdge: .leading)
//        self.autoPinEdge(toSuperviewEdge: .trailing)
//        self.autoPinEdge(toSuperviewEdge: .bottom)
//
//        self.uiPostView.autoPinEdge(toSuperviewEdge: .top)
//        self.uiPostView.autoPinEdge(toSuperviewEdge: .leading)
//        self.uiPostView.autoPinEdge(toSuperviewEdge: .trailing)
//        self.uiPostView.autoPinEdge(toSuperviewEdge: .bottom)
//
//
//        super.updateConstraints()
//    }
//
//}
