//
//  ListPostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 26/11/22.
//

import UIKit
import PureLayout
import SkeletonView

protocol ListToPostProtocol {
    func sendData(idPost: Post, isSavePost: Bool)
}

class ListPostViewController: UIViewController {
    // MARK: UI
    var uiMainView: UIView = {
        let view = UIView(frame: .zero)
        view.isSkeletonable = true
        return view
    }()
    
    var uiTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor(named: "crema")
        tableView.isSkeletonable = true
        tableView.isHidden = true
        return tableView
    }()
    
    var uiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16.0
        stackView.isHidden = true
        return stackView
    }()
    
    var titleEmpty: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Ups! tenemos un problema \nPronto nuestro Team lo solucionará"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: fontItalic, size: 18)
        return label
    }()
    
    var imageWarning: UIImageView = {
        let imageName = UIImage(named: "warning")
        let imagen = UIImageView(image: imageName)
        return imagen
    }()
    
    // MARK: controllers
    private var goToPostView = PostViewController()
    
    // MARK: references delegate
    var delegateListToPost: ListToPostProtocol!
    private var delegatePostDataViewModel: PostDataViewModel? = nil
    
    // MARK: another data
    var dataArrayPost = [Post]()
    var gbIsLoading: Bool = true
    private var persistenceData = PersistenceData()
    private var registerIfSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        if delegatePostDataViewModel == nil {
            delegatePostDataViewModel = PostDataViewModel(delegate: self, apiClient: APIClient(requestBuilderURL: APIBuild()))
            delegatePostDataViewModel?.delegate = self
        }
        self.delegateListToPost = goToPostView
        setupView()
        delegatePostDataViewModel?.apiGetPostList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.navigationController?.navigationBar.layer.shadowRadius = 8
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.7
        if dataArrayPost.count > 0 {
            if registerIfSave {
                uploadDataFavorite()
            } else {
                uploadDataRequest()
            }
        }
    }

    
}

extension ListPostViewController {
    
    private func setupView() {
        buildStackView()
        addElementsToView()
        setupNavigationBar()
        configureConstraints()
        setupTableView()
        showShimmer()
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Post"
        addElementBarRigth(iconName: "heart.text.square.fill", actionName: #selector(loadingTableFavorites))
    }
    
    private func setupTableView(){
        uiTableView.delegate = self
        uiTableView.dataSource = self
        uiTableView.isSkeletonable = true
        uiTableView.translatesAutoresizingMaskIntoConstraints = false
        uiTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "cellPost")
        uiTableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private func loadingTableFavorites() {
        NotificationBannerRender.showBanner(lsTitleBanner: "Cargando...", lsDescriptionBanner: "elementos guardados", styleBanner: .info)
        uploadDataFavorite()
        addElementBarRigth(iconName: "arrow.clockwise.icloud.fill", actionName: #selector(loadingTableRequest))
    }
    
    func uploadDataFavorite() {
        let arrayData = persistenceData.getPostByUser()
        dataArrayPost = arrayData
        registerIfSave = true
        if dataArrayPost.count == 0 {
            DispatchQueue.main.async {
                self.uiTableView.isHidden = true
                self.uiStackView.isHidden = false
                self.titleEmpty.text = "No hay datos guardados aun"
                self.imageWarning.image = UIImage(named: "post")
            }
        } else {
            DispatchQueue.main.async {
                self.uiStackView.isHidden = true
                self.uiTableView.isHidden = false
            }
            self.showAndReloadTable()
        }
    }
    
    @objc private func loadingTableRequest() {
        NotificationBannerRender.showBanner(lsTitleBanner: "Cargando...", lsDescriptionBanner: "elementos", styleBanner: .info)
        addElementBarRigth(iconName: "heart.text.square.fill", actionName: #selector(loadingTableFavorites))
        uploadDataRequest()
    }
    
    func uploadDataRequest() {
        dataArrayPost = []
        registerIfSave = false
        delegatePostDataViewModel?.apiGetPostList()
    }
        
    func navigatePostView(idPost: Post) {
        delegateListToPost.sendData(idPost: idPost, isSavePost: registerIfSave)
        let navigationController = UINavigationController(rootViewController: goToPostView)
        self.navigationController?.pushViewController(goToPostView, animated: true)
    }
    
    private func showAndReloadTable() {
        DispatchQueue.main.async {
            self.uiStackView.isHidden = true
            self.uiTableView.isHidden = false
            self.uiTableView.reloadData()
            self.uiTableView.hideSkeleton()
            self.view.layoutIfNeeded()
        }
    }
    
    private func showEmptyView() {
        DispatchQueue.main.async {
            self.imageWarning.image = UIImage(named: "warning")
            self.titleEmpty.text = "Ups! tenemos un problema \nPronto nuestro Team lo solucionará"
            self.uiTableView.isHidden = true
            self.uiStackView.isHidden = false
        }
    }

}


// MARK: ViewModel
extension ListPostViewController: PostViewModelToViewBinding {
    func postViewModel(didGetError aobError: Any) {
        showEmptyView()
    }
    
    func postViewModel(didGetPost aobPostList: ArrayPost) {
        dataArrayPost = aobPostList
        if dataArrayPost.count > 0 {
            gbIsLoading = false
            DispatchQueue.main.async {
                self.showAndReloadTable()
            }
        } else {
            showEmptyView()
        }
    }
}
