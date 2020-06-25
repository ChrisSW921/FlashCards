//
//  DeleteTableViewController.swift
//  FlashCards
//
//  Created by Chris Withers on 5/30/20.
//  Copyright © 2020 Chris Withers. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework


class DeleteTableViewController: UITableViewController {

    var itemArray = [Translation]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Translation.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        //navigationController?.navigationBar.barTintColor = FlatSkyBlue()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.numberOfLines = 0
        
        if itemArray.count == 0 {
            cell.backgroundColor = FlatSkyBlue()
        }else {
            cell.backgroundColor = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(itemArray.count))
        }
        
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = "🇫🇷French: \(itemArray[indexPath.row].french) |  🇬🇧English: \(itemArray[indexPath.row].english)"
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Translation].self, from: data)
        } catch {
            print("Error")
            }
        }
    }

}
extension DeleteTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.itemArray.remove(at: indexPath.row)

                   let encoder = PropertyListEncoder()

                   do {
                    let data = try encoder.encode(self.itemArray)
                    try data.write(to: self.dataFilePath!)
                   } catch{
                       print("error")
                   }
            self.loadItems()
            print("deleted")
        }

        deleteAction.image = UIImage(named: "TrashImage")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
