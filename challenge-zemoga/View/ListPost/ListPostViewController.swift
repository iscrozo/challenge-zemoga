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
        let tableView = UITableView()
        tableView.isSkeletonable = true
        return tableView
    }()
    
    
    // MARK: controllers
    private var goToPostView = PostViewController()
    
    // MARK: references delegate
    var delegateListToPost: ListToPostProtocol!
    private var delegatePostDataViewModel: PostDataViewModel? = nil
    
    // MARK: another data
    private var dataArrayPost = [Post]()
    private var gbIsLoading: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "crema")
        
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
        view.addSubview(uiMainView)
        uiMainView.addSubview(uiTableView)
        setupNavigationBar()
        configureConstraints()
        setupTableView()
        showShimmer()
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Post"
        let backButton = UIBarButtonItem(title: buttonBackLabel, style: .plain, target: self, action: nil)
        let viewFavorites = UIBarButtonItem(image: UIImage(systemName: "heart.circle.fill"), style: .done, target: self, action: #selector(viewFavorites))
        self.navigationItem.rightBarButtonItem = viewFavorites
    }
    
    
    private func setupTableView(){
        uiTableView.delegate = self
        uiTableView.dataSource = self
        uiTableView.isSkeletonable = true
        self.uiTableView.bounces = true
        uiTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc private func viewFavorites() {
        
    }
    
    private func showShimmer() {
        self.view.showAnimatedGradientSkeleton()
        self.uiTableView.showAnimatedGradientSkeleton()
    }
    
    private func configureConstraints() {
        // ui Main View
        uiMainView.autoPinEdge(.top, to: .top, of: view, withOffset: 99.0)
        uiMainView.autoPinEdge(.bottom, to: .bottom, of: view)
        uiMainView.autoPinEdge(.leading, to: .leading, of: view)
        uiMainView.autoPinEdge(.trailing, to: .trailing, of: view)

        // iu Table View
        uiTableView.autoPinEdge(.top, to: .top, of: uiMainView)
        uiTableView.autoPinEdge(.bottom, to: .bottom, of: uiMainView)
        uiTableView.autoPinEdge(.leading, to: .leading, of: uiMainView)
        uiTableView.autoPinEdge(.trailing, to: .trailing, of: uiMainView)
        self.view.layoutIfNeeded()
    }
        
    private func navigatePostView(idPost: Post) {
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


//MARK: table view data source
extension ListPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCounts = 0
        rowCounts = gbIsLoading ? 10 : dataArrayPost.count
        return rowCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.isSkeletonable = true
        if gbIsLoading
        {
            cell.showAnimatedGradientSkeleton()
        } else {
            cell.textLabel?.text = dataArrayPost[indexPath.row].title
            cell.textLabel?.textColor = .black
            cell.hideSkeleton()
        }
        return cell
    }
    
}

//MARK: table view delegate
extension ListPostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigatePostView(idPost: dataArrayPost[indexPath.row])
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
