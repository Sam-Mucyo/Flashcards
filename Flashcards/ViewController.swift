//
//  ViewController.swift
//  Flashcards
//
//  Created by Sam Mucyo on 2/26/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapFlashcard = UITapGestureRecognizer(target: self, action: #selector(didTapFlashcard(_:)) )
        tapFlashcard.numberOfTapsRequired = 1
        tapFlashcard.numberOfTouchesRequired = 1
        frontLabel.addGestureRecognizer(tapFlashcard)
        frontLabel.isUserInteractionEnabled = true
        
    }
    @IBAction func didTapFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
}

