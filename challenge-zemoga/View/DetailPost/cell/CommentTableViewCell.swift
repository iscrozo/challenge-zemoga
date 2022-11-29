//
//  CommentTableViewCell.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import UIKit
import PureLayout
import SkeletonView

class CommentTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .natural
        title.numberOfLines = 0
        title.isSkeletonable = true
        title.text = "Lorem Ipsum"
        title.font = UIFont(name: fontRegular, size: 15)
        return title
    }()
    private let emailLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .natural
        title.numberOfLines = 0
        title.isSkeletonable = true
        title.text = "Lorem@Ipsum"
        title.font = UIFont(name: fontRegular, size: 13)
        return title
    }()
    private let bodyLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .natural
        title.numberOfLines = 0
        title.isSkeletonable = true
        title.text = "Lorem Ipsum"
        title.font = UIFont(name: fontRegular, size: 14)
        return title
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        return view
    }()
    
    var uiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 5.0
        return stackView
    }()
        
    var postComment: PostCommentElement? {
        didSet {
            nameLabel.text = postComment?.name
            emailLabel.text = postComment?.email
            bodyLabel.text = postComment?.body
            self.hideSkeleton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: colorCremaValue)
        self.showAnimatedGradientSkeleton()
        buildStackView()
        customCell()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CommentTableViewCell {
    
    func buildStackView() {
        uiStackView.addArrangedSubview(nameLabel)
        uiStackView.addArrangedSubview(emailLabel)
        uiStackView.addArrangedSubview(bodyLabel)
    }
    
    func customCell() {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func configureView() {
        contentView.addSubview(containerView)
        containerView.addSubview(uiStackView)
        
        containerView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 0)
        containerView.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -5)
        containerView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 5)
        containerView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: 0)
        
        uiStackView.autoPinEdge(.top, to: .top, of: containerView, withOffset: 10)
        uiStackView.autoPinEdge(.trailing, to: .trailing, of: containerView, withOffset: 0)
        uiStackView.autoPinEdge(.leading, to: .leading, of: containerView, withOffset: 20)
        uiStackView.autoPinEdge(.bottom, to: .bottom, of: containerView, withOffset: -10)
        
    }
}
