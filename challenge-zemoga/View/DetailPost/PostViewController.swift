//
//  PostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import PureLayout
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
        view.backgroundColor = .white
        setupView()
        setupNavigationBar()
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
    
    private func addElementsForView() {
        self.view.addSubview(labelTitle)
        self.view.addSubview(labelDescription)
        self.view.addSubview(separatorView)
        self.view.addSubview(userImage)
        self.view.addSubview(aboutUser)
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
        }
        showBanner(lsTitleBanner: titleBanner, lsDescriptionBanner: descriptionBanner, styleBanner: styleBanner)
    }
    
    private func showBanner(lsTitleBanner: String, lsDescriptionBanner: String, styleBanner: BannerStyle){
        NotificationBanner(title: lsTitleBanner,  subtitle: lsDescriptionBanner,  style: styleBanner).show()
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
}

extension PostViewController {
    private func configureConstraints(){
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

extension PostViewController: ListToPostProtocol {
    func sendData(idPost: Post) {
        labelTitle.text = idPost.title
        labelDescription.text = idPost.body
        if delegatePostDataViewModel == nil {
            delegatePostDataViewModel = PostDataViewModel(delegate: self, apiClient: APIClient(requestBuilderURL: APIBuild()))
            delegatePostDataViewModel?.delegate = self
        }
        delegatePostDataViewModel?.apiGetPostByUser(userId: idPost.id)
    }
}


extension PostViewController: PostViewModelToViewBinding {
    func postViewModel(didGetError aobError: Error) {
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
