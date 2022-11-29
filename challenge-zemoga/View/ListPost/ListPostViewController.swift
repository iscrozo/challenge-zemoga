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
    func sendData(idPost: Post)
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
        return tableView
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
    }

    
}

extension ListPostViewController {
    
    private func setupView() {
        addElementsToView()
        setupNavigationBar()
        configureConstraints()
        setupTableView()
        showShimmer()
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Post"
        addElementBarRigth(iconName: "list.star", actionName: #selector(loadingTableFavorites))
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
        let arrayData = persistenceData.getPostByUser()
        dataArrayPost = []
        DispatchQueue.main.async {
            self.reloadTable()
        }
        addElementBarRigth(iconName: "list.dash", actionName: #selector(loadingTableRequest))
    }
    
    @objc private func loadingTableRequest() {
        NotificationBannerRender.showBanner(lsTitleBanner: "Cargando...", lsDescriptionBanner: "elementos", styleBanner: .info)
        addElementBarRigth(iconName: "list.star", actionName: #selector(loadingTableFavorites))
        dataArrayPost = []
        delegatePostDataViewModel?.apiGetPostList()
        DispatchQueue.main.async {
            self.reloadTable()
        }
    }
        
    func navigatePostView(idPost: Post) {
        delegateListToPost.sendData(idPost: idPost)
        let navigationController = UINavigationController(rootViewController: goToPostView)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.uiTableView.reloadData()
            self.uiTableView.hideSkeleton()
        }
    }

}


// MARK: ViewModel
extension ListPostViewController: PostViewModelToViewBinding {
    func postViewModel(didGetError aobError: Error) {
        print(aobError)
    }
    
    func postViewModel(didGetPost aobPostList: ArrayPost) {
        dataArrayPost = aobPostList
        if dataArrayPost.count > 0 {
            gbIsLoading = false
            DispatchQueue.main.async {
                self.reloadTable()
            }
        }
    }
}
