//
//  PostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import NotificationBannerSwift
import SkeletonView

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
        let image = UIImage(systemName: "person.circle")
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
        tableView.backgroundColor = UIColor(named: "crema")
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
    private var delegatePostDataViewModel: PostDataViewModel? = nil
    private var persistenceData = PersistenceData()
    var isFavourited = false
    var postCurrently: Post = Post(userID: 0, id: 0, title: "", body: "")
    var dataArrayPostComment = [PostCommentElement]()
    var gbIsLoading: Bool = true
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PostViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "crema")
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
        uiTableViewComments.register(CommentTableViewCell.self, forCellReuseIdentifier: "cellComment")
        uiTableViewComments.rowHeight = UITableView.automaticDimension
    }
    
    private func setupView() {
        addElementsForView()
        buildStackUser()
        buildStackBody()
        configureConstraints()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Post"
        let backButton = UIBarButtonItem(title: buttonBackLabel, style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
        addNavigationButtonFavorite()
    }
    
    @objc func backAction() {
        dismiss(animated: true)
    }
    
    @objc func addFavoritePost() {
        addNavigationButtonFavorite()
        var titleBanner = "", descriptionBanner = ""
        var styleBanner: BannerStyle
        if isFavourited {
            titleBanner = "Satisfactorio!"
            descriptionBanner = "Ha sido eliminado correctamente"
            styleBanner = .info
        } else {
            titleBanner = "Satisfactorio!"
            descriptionBanner = "Se ha guardado correctamente"
            styleBanner = .success
            saveInUserDefault(postData: postCurrently)
        }
        NotificationBannerRender.showBanner(lsTitleBanner: titleBanner, lsDescriptionBanner: descriptionBanner, styleBanner: styleBanner)
    }
    
    private func addNavigationButtonFavorite() {
        var uiImageItem: UIImage = {
           let uiImage = UIImage()
            return uiImage
        }()
        if !isFavourited {
            uiImageItem = UIImage(systemName: "star")!
            isFavourited = !isFavourited
        } else {
            uiImageItem = UIImage(systemName: "star.fill")!
            isFavourited = !isFavourited
        }
        let addFavorites = UIBarButtonItem(image: uiImageItem, style: .done, target: self, action: #selector(addFavoritePost))
        self.navigationItem.rightBarButtonItems = [addFavorites]
    }
    
    private func saveInUserDefault(postData: Post) {
        var getArrayDefault = persistenceData.getPostByUser()
        getArrayDefault.append(postData)
        persistenceData.savePost(postData: getArrayDefault)
    }
    
    private func reloadTable() {
        self.uiTableViewComments.isHidden = false
        self.uiTableViewComments.reloadData()
        self.uiTableViewComments.hideSkeleton()
    }
}

//MARK: receive data the view List
extension PostViewController: ListToPostProtocol {
    func sendData(idPost: Post) {
        postCurrently = idPost
        labelTitle.text = postCurrently.title
        labelDescription.text = postCurrently.body
        if delegatePostDataViewModel == nil {
            delegatePostDataViewModel = PostDataViewModel(delegate: self, apiClient: APIClient(requestBuilderURL: APIBuild()))
            delegatePostDataViewModel?.delegate = self
        }
        delegatePostDataViewModel?.apiGetPostByUser(userId: idPost.id)
    
    }
}

//MARK: viewmodel data
extension PostViewController: PostViewModelToViewBinding {
    func postViewModel(didGetError aobError: Any) {
        print(aobError)
        self.uiTableViewComments.isHidden = true
    }
    
    func postViewModel(didGetPostByUSer aobPostByUser: PostByUser) {
        let userInfo = aobPostByUser
        if userInfo.count > 0 {
            guard let info = userInfo.first else {
                return
            }
            DispatchQueue.main.async {
                self.uiStackViewUser.isHidden = false
                self.aboutUser.text = "\(info.name) \n\(info.email) \n\(info.phone) \n\(info.website)"
                self.separatorView2.isHidden = false
            }
            
        } else {
            DispatchQueue.main.async {
                self.uiStackViewUser.isHidden = true
                self.separatorView2.isHidden = true
                self.uiStackViewUser.isHidden = true
            }
        }
        self.delegatePostDataViewModel?.apiGetPostIdComment(postId: self.postCurrently.id)
    }
    
    func postViewModel(didGetPostIdComments aobPostIdComments: PostComment) {
        dataArrayPostComment = aobPostIdComments
        if dataArrayPostComment.count > 0 {
            gbIsLoading = false
            DispatchQueue.main.async {
                self.reloadTable()
            }
        } else {
            DispatchQueue.main.async {
                self.uiTableViewComments.isHidden = true
            }
        }
    }
}
