//
//  Extension+VM+PostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 29/11/22.
//

import Foundation
import UIKit

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
