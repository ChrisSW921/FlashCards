//
//  PracticeViewController.swift
//  FlashCards
//
//  Created by Chris Withers on 5/26/20.
//  Copyright © 2020 Chris Withers. All rights reserved.
//

import UIKit



class PracticeViewController: UIViewController {
    var direction: String = "direction"
    
    @IBOutlet weak var frenchCard: UITextField!
    
    @IBOutlet weak var englishCard: UITextField!
    
    var currentIndex = -1
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Translation.plist")
    
    var itemArray = [Translation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    @IBAction func nextCard(_ sender: UIButton) {
        if direction == "frenchToEnglish"{
            if itemArray.count == 0 {
                englishCard.text = "No cards added"
                frenchCard.text = "No cards added"
            }else {
                currentIndex += 1
                if currentIndex == (itemArray.count) {
                    currentIndex = 0
                }
                frenchCard.text = "🇫🇷 \(itemArray[currentIndex].french)"
                englishCard.text = "🇬🇧 ?"
            }
            
        }else {
            if itemArray.count == 0 {
                englishCard.text = "No cards added"
                frenchCard.text = "No cards added"
            }else {
                currentIndex += 1
                if currentIndex == (itemArray.count) {
                    currentIndex = 0
                }
                frenchCard.text = "🇫🇷 ?"
                englishCard.text = "🇬🇧 \(itemArray[currentIndex].english)"
            }
        }
    }
    
    @IBAction func showCard(_ sender: UIButton) {
        if direction == "frenchToEnglish" {
            if itemArray.count == 0 {
                englishCard.text = "No cards added"
                frenchCard.text = "No cards added"
            }else if currentIndex == -1{
                englishCard.text = "No card selected"
                frenchCard.text = "No card selected"
            }else{
                englishCard.text = "🇬🇧 \(itemArray[currentIndex].english)"
            }
            
        }else {
            if itemArray.count == 0 {
                englishCard.text = "No cards added"
                frenchCard.text = "No cards added"
            }else if currentIndex == -1{
                englishCard.text = "No card selected"
                frenchCard.text = "No card selected"
            }else{
                frenchCard.text = "🇫🇷 \(itemArray[currentIndex].french)"
            }
        }
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
