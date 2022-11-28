//
//  ListPostViewController+TableView.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import Foundation
import UIKit

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
