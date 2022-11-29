//
//  Extension+TableView+PostViewController.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import Foundation
import UIKit

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCounts = 0
        rowCounts = gbIsLoading ? 10 : dataArrayPostComment.count
        return rowCounts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComment", for: indexPath) as! CommentTableViewCell
        cell.isSkeletonable = true
        if gbIsLoading
        {
            cell.showAnimatedGradientSkeleton()
        } else {
            let data = dataArrayPostComment[indexPath.row]
            cell.postComment = data
            cell.hideSkeleton()
        }
        return cell
    }
        
}
