//
//  ListPostView.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import PureLayout

class ListPostView: UIView {

    weak var uiViewMain: UIView!
    weak var uiTableView: UITableView!
    let spaceVerticalViews: CGFloat = 10.0, spaceHorizontalViews: CGFloat = 20.0
    
    required init() {
        super.init(frame: .zero)
        createElementeViewMain()
        createElementTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

}

extension ListPostView {
    private func createElementeViewMain() {
//        let lobScreensize: CGRect = UIScreen.main.bounds
//        let lobScreenWidth = lobScreensize.width
//        let lobScreenHeight = lobScreensize.height
        let viewMain = UIView(frame: .zero)
        viewMain.backgroundColor = .red
//        viewMain.autoSetDimension(.height, toSize: lobScreenHeight)
//        viewMain.autoSetDimension(.width, toSize: lobScreenWidth)
        self.uiViewMain = viewMain
        self.addSubview(uiViewMain)
    }
    
    private func createElementTableView(){
        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .blue
        self.uiTableView = tableView
//        self.uiViewMain.addSubview(uiTableView)
    }
}

extension ListPostView {
    override func updateConstraints() {
        self.autoPinEdge(toSuperviewEdge: .top)
        self.autoPinEdge(toSuperviewEdge: .leading)
        self.autoPinEdge(toSuperviewEdge: .trailing)
        self.autoPinEdge(toSuperviewEdge: .bottom)
        
        self.uiViewMain.autoPinEdge(toSuperviewEdge: .top)
        self.uiViewMain.autoPinEdge(toSuperviewEdge: .leading)
        self.uiViewMain.autoPinEdge(toSuperviewEdge: .trailing)
        self.uiViewMain.autoPinEdge(toSuperviewEdge: .bottom)
        
//        self.uiTableView.autoPinEdge(.top, to: .top, of: uiViewMain)
//        self.uiTableView.autoPinEdge(.bottom, to: .bottom, of: uiViewMain)
//        self.uiTableView.autoPinEdge(.trailing, to: .trailing, of: uiViewMain)
//        self.uiTableView.autoPinEdge(.leading, to: .leading, of: uiViewMain)
//        self.uiTableView.autoMatch(.height, to: .height, of: uiViewMain)
//        self.uiTableView.autoMatch(.width, to: .width, of: uiViewMain)

//        uiTableView.translatesAutoresizingMaskIntoConstraints = false
//        uiTableView.topAnchor.constraint(equalTo: uiViewMain.topAnchor).isActive = true
//        uiTableView.leftAnchor.constraint(equalTo: uiViewMain.leftAnchor).isActive = true
//        uiTableView.bottomAnchor.constraint(equalTo: uiViewMain.bottomAnchor).isActive = true
//        uiTableView.rightAnchor.constraint(equalTo: uiViewMain.rightAnchor).isActive = true
//        
        super.updateConstraints()
    }
    
}
