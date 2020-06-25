//
//  ChooseDirectionViewController.swift
//  FlashCards
//
//  Created by Chris Withers on 6/3/20.
//  Copyright © 2020 Chris Withers. All rights reserved.
//

import UIKit

class ChooseDirectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func frenchToEnglish(_ sender: UIButton) {
        
    }
    
    
    @IBAction func englishToFrench(_ sender: UIButton) {
        
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "frenchtoenglish"{
            let destinationVC = segue.destination as! PracticeViewController
            destinationVC.direction = "frenchToEnglish"
        }
        if segue.identifier == "englishtofrench" {
           // print("English to French")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    

}
