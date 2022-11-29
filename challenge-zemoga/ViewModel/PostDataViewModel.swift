//
//  PostDataViewModel.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 27/11/22.
//

import Foundation

protocol PostViewModelToViewBinding: class {
    func postViewModel(didGetError aobError: Any)
    func postViewModel(didGetPost aobPostList: ArrayPost)
    func postViewModel(didGetPostByUSer aobPostByUser: PostByUser)
    func postViewModel(didGetPostIdComments aobPostIdComments: PostComment)
}

extension PostViewModelToViewBinding {
    func postViewModel(didGetError aobError: Any) { }
    func postViewModel(didGetPost aobPostList: ArrayPost) { }
    func postViewModel(didGetPostByUSer aobPostByUser: PostByUser) { }
    func postViewModel(didGetPostIdComments aobPostIdComments: PostComment) { }
}

class PostDataViewModel {
    
    weak var delegate: PostViewModelToViewBinding?
    var apiClient: APIClient?
    
    init(delegate: PostViewModelToViewBinding, apiClient: APIClient){
        self.delegate = delegate
        self.apiClient = apiClient
    }
    
    func setDelegate(_ delegate: PostViewModelToViewBinding) {
        self.delegate = delegate
    }
}

extension PostDataViewModel {
    func apiGetPostList() {
        apiClient?.requestData(apiData: .queryPostAll(limitData: 0)) { [weak self] (result: Result<Any, Error>) in
            switch result {
            case .success(let postList):
                guard let dataPost = self?.decodeGetPost(data: postList, typeData: .dataGetPostList) as? ArrayPost else {
                    return
                }
                self?.delegate?.postViewModel(didGetPost: dataPost)
            case .failure(let errorRequest):
                print(errorRequest)
                self?.delegate?.postViewModel(didGetPost: [] )
            }
        }
    }
    
    func apiGetPostByUser(userId: Int) {
        apiClient?.requestData(apiData: .queryUserId(userId: userId)) { [weak self] (result: Result<Any, Error>) in
            switch result {
            case .success(let postByUser):
                guard let dataPostByUser = self?.decodeGetPost(data: postByUser, typeData: .dataGetPostByUser) as? PostByUser else {
                    return
                }
                self?.delegate?.postViewModel(didGetPostByUSer: dataPostByUser)
            case .failure(let errorRequest):
                print(errorRequest)
                self?.delegate?.postViewModel(didGetPost: [] )
            }
        }
    }
    
    func apiGetPostIdComment(postId: Int) {
        apiClient?.requestData(apiData: .queryPostId(postId: postId)) { [weak self] (result: Result<Any, Error>) in
            switch result {
            case .success(let postComments):
                guard let dataPostIdComments = self?.decodeGetPost(data: postComments, typeData: .dataGetPostIdComment) as? PostComment else {
                    return
                }
                self?.delegate?.postViewModel(didGetPostIdComments: dataPostIdComments)
            case .failure(let errorRequest):
                print(errorRequest)
                self?.delegate?.postViewModel(didGetPost: [] )
            }
        }
    }
}


extension PostDataViewModel {
    
    private func decodeGetPost(data: Any, typeData: typeDataDecode) -> AnyObject? {
        if let lsJsonData = try? JSONSerialization.data( withJSONObject: data, options: []) {
            
            guard  let lsData = String(data: lsJsonData, encoding: .utf8) else {
                return nil
            }
            
            switch typeData {
            case .dataGetPostList:
                guard let postList = ArrayPost(asJsonString: lsData) else {
                    return nil
                }
                return postList as AnyObject
            case .dataGetPostByUser:
                guard let postByUser = PostByUser(asJsonString: lsData) else {
                    return nil
                }
                return postByUser as AnyObject
            case .dataGetPostIdComment:
                guard let postByUser = PostComment(asJsonString: lsData) else {
                    return nil
                }
                return postByUser as AnyObject
            }
        
        }
        return nil
    }
    
}


private enum typeDataDecode {
    case dataGetPostList, dataGetPostByUser, dataGetPostIdComment
}
