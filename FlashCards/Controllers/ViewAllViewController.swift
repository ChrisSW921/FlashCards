//
//  ViewAllViewController.swift
//  FlashCards
//
//  Created by Chris Withers on 5/30/20.
//  Copyright © 2020 Chris Withers. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewAllViewController: UITableViewController {

    var itemArray = [Translation]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Translation.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        if itemArray.count == 0 {
            cell.backgroundColor = FlatSkyBlue()
        }else {
            cell.backgroundColor = FlatSkyBlue().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(itemArray.count))
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "🇫🇷 \(itemArray[indexPath.row].french) |  🇬🇧 \(itemArray[indexPath.row].english)"
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
