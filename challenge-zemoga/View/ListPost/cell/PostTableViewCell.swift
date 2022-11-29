//
//  PostTableViewCell.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import UIKit
import PureLayout
import SkeletonView

class PostTableViewCell: UITableViewCell {
    
    private let titlePost: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .natural
        title.numberOfLines = 0
        title.isSkeletonable = true
        title.text = "Lorem Ipsum"
        title.font = UIFont(name: fontRegular, size: 17)
        return title
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()
    
    let colorCrema = UIColor(named: colorCremaValue)
    let colorAquaMarina = UIColor(named: colorAquaMarinaValue)
    let colorMorado = UIColor(named: colorMoradoValue)
    
    var postData: Post? {
        didSet {
            titlePost.text = postData?.title
            self.hideSkeleton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = colorCrema
        self.showAnimatedGradientSkeleton()
        customCell()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let backgroundView = UIView()
        if selected {
            backgroundView.backgroundColor = colorMorado
            self.selectedBackgroundView = backgroundView
            contentView.backgroundColor = colorAquaMarina
        } else {
            backgroundView.backgroundColor = .clear
            self.selectedBackgroundView = backgroundView
            contentView.backgroundColor = colorCrema
        }
    }

}

extension PostTableViewCell {
    
    func customCell() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func configureView() {
        contentView.addSubview(containerView)
        containerView.addSubview(titlePost)
        
        containerView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 10)
        containerView.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -5)
        containerView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 5)
        containerView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -10)
        
        titlePost.autoPinEdge(.top, to: .top, of: containerView, withOffset: 0)
        titlePost.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: -10)
        titlePost.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 30)
        titlePost.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: 0)
    }
}
