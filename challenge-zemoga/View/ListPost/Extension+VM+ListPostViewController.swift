//
//  Extension+VM+ListPostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 29/11/22.
//

import Foundation


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
