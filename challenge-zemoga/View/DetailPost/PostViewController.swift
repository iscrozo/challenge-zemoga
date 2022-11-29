//
//  PostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import NotificationBannerSwift

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
    
    //MARK: another variables
    private var delegatePostDataViewModel: PostDataViewModel? = nil
    private var persistenceData = PersistenceData()
    var isFavourited = false
    var postCurrently: Post = Post(userID: 0, id: 0, title: "", body: "")
    
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
    
    private func setupView() {
        addElementsForView()
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
    }
    
    func postViewModel(didGetPostByUSer aobPostByUser: PostByUser) {
        guard let userInfo = aobPostByUser.first else {
            return
        }
        DispatchQueue.main.async {
            self.aboutUser.text = "\(userInfo.name) \n\(userInfo.email) \n\(userInfo.phone) \n\(userInfo.website)"
        }
    }
}
