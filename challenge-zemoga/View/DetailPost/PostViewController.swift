//
//  PostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import NotificationBannerSwift
import SkeletonView

public enum TypeViewRenderPost {
    case viewPostRequest, viewPostSave
}

class PostViewController: UIViewController {
    
    // MARK: UI
    var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: fontBold, size: 18)
        return label
    }()
    
    var labelDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: fontRegular, size: 15)
        return label
    }()
    
    var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
       return separatorView
    }()
    
    var aboutUser: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.textAlignment = .left
        name.numberOfLines = 0
        name.font = UIFont(name: fontRegular, size: 13)
        return name
    }()
    
    var userImage: UIImageView = {
        let image = UIImage(systemName: iconPerson)
        let userImage = UIImageView()
        userImage.image = image
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    var separatorView2: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
       return separatorView
    }()
    
    var uiTableViewComments: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isSkeletonable = true
        tableView.backgroundColor = UIColor(named: colorCremaValue)
        return tableView
    }()
    
    var uiStackViewUser: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 5.0
        return stackView
    }()
    
    var uiStackViewBody: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 5.0
        return stackView
    }()
    
    //MARK: another variables
    internal var delegatePostDataViewModel: PostDataViewModel? = nil
    private var persistenceData = PersistenceData()
    var isFavourited = false
    var postCurrently: Post = Post(userID: 0, id: 0, title: "", body: "")
    var dataArrayPostComment = [PostCommentElement]()
    var gbIsLoading: Bool = true
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("PostViewController init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PostViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: colorCremaValue)
        setupView()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.navigationController?.navigationBar.layer.shadowRadius = 8
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.7
    }

}


extension PostViewController {
    
    private func setupTableView() {
        uiTableViewComments.dataSource = self
        uiTableViewComments.isSkeletonable = true
        uiTableViewComments.translatesAutoresizingMaskIntoConstraints = false
        uiTableViewComments.register(CommentTableViewCell.self, forCellReuseIdentifier: idCellComment)
        uiTableViewComments.rowHeight = UITableView.automaticDimension
    }
    
    private func setupView() {
        addElementsForView()
        buildStackUser()
        buildStackBody()
        configureConstraints()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = titleNavigation
        let backButton = UIBarButtonItem(title: buttonBackLabel, style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func customRenderNavigation(typeView: TypeViewRenderPost) {
        switch typeView {
        case .viewPostRequest:
            addNavigationButtonFavorite()
        case .viewPostSave:
            addNavigationButtonTrash()
        }
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addFavoritePost() {
        addNavigationButtonFavorite()
        saveInUserDefault(postData: postCurrently)
    }
    
    @objc func deleteFavoritePost() {
        deleteInUserDefault(posData: postCurrently)
    }
    
    private func addNavigationButtonFavorite() {
        var uiImageItem: UIImage = {
           let uiImage = UIImage()
            return uiImage
        }()
        if !isFavourited {
            uiImageItem = UIImage(systemName: iconStarLine)!
            isFavourited = !isFavourited
            let addFavorites = UIBarButtonItem(image: uiImageItem, style: .done, target: self, action: #selector(addFavoritePost))
            self.navigationItem.rightBarButtonItems = [addFavorites]
        } else {
            uiImageItem = UIImage(systemName: iconTrash)!
            isFavourited = !isFavourited
            let addFavorites = UIBarButtonItem(image: uiImageItem, style: .done, target: self, action: #selector(deleteFavoritePost))
            self.navigationItem.rightBarButtonItems = [addFavorites]
        }
    }
    
    private func addNavigationButtonTrash() {
        var uiImageItem: UIImage = {
           let uiImage = UIImage()
            return uiImage
        }()
        uiImageItem = UIImage(systemName: iconTrash)!
        isFavourited = !isFavourited
        let addFavorites = UIBarButtonItem(image: uiImageItem, style: .done, target: self, action: #selector(deleteFavoritePost))
        self.navigationItem.rightBarButtonItems = [addFavorites]
    }
    
    private func saveInUserDefault(postData: Post) {
        let validationData = persistenceData.trySavePost(postData: postData )
        if validationData {
            NotificationBannerRender.showBanner(lsTitleBanner: titleReady2, lsDescriptionBanner: titleSuccesSavePost, styleBanner: .success)
        } else {
            NotificationBannerRender.showBanner(lsTitleBanner: titleBadNews, lsDescriptionBanner: titleExistSavePost, styleBanner: .info)
            backAction()
        }
        
    }
    
    private func deleteInUserDefault(posData: Post) {
        persistenceData.deletePostId(postData: posData)
        NotificationBannerRender.showBanner(lsTitleBanner: titleReady, lsDescriptionBanner: titleSuccessDeletePost, styleBanner: .success)
        backAction()
    }
    
    func reloadTable() {
        self.uiTableViewComments.isHidden = false
        self.uiTableViewComments.reloadData()
        self.uiTableViewComments.hideSkeleton()
    }
}

//MARK: receive data the view List
extension PostViewController: ListToPostProtocol {
    func sendData(idPost: Post, isSavePost: Bool) {
        postCurrently = idPost
        labelTitle.text = postCurrently.title
        labelDescription.text = postCurrently.body
        isFavourited = isSavePost
        let typeView = isSavePost ? TypeViewRenderPost.viewPostSave : TypeViewRenderPost.viewPostRequest
        DispatchQueue.main.async {
            self.customRenderNavigation(typeView: typeView)
        }
        
        if delegatePostDataViewModel == nil {
            delegatePostDataViewModel = PostDataViewModel(delegate: self, apiClient: APIClient(requestBuilderURL: APIBuild()))
            delegatePostDataViewModel?.delegate = self
        }
        delegatePostDataViewModel?.apiGetPostByUser(userId: idPost.id)
    
    }
}
