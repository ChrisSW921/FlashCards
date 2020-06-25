//
//  AddCardsViewController.swift
//  FlashCards
//
//  Created by Chris Withers on 5/26/20.
//  Copyright © 2020 Chris Withers. All rights reserved.
//

import UIKit


class AddCardsViewController: UIViewController {
    
    @IBOutlet weak var frenchWord: UITextField!
    
    @IBOutlet weak var englishWord: UITextField!
    
    var items = [Translation]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Translation.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    
    
    @IBAction func addCard(_ sender: UIButton) {
        
        let item = Translation()
        item.english = englishWord.text!
        item.french = frenchWord.text!
        items.append(item)
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath!)
        } catch{
            print("error")
        }
        
        frenchWord.text = ""
        englishWord.text = ""
        
    }
    
    func loadItems() {
    if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
        items = try decoder.decode([Translation].self, from: data)
    } catch {
        print("Error")
        }
    }
}
}
