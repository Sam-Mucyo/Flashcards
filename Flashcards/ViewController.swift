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
        backLabel.addGestureRecognizer(tapFlashcard)
        backLabel.isUserInteractionEnabled = true
        frontLabel.isUserInteractionEnabled = true
        
    }
    @IBAction func didTapFlashcard(_ sender: Any) {
        if frontLabel.isHidden {
            frontLabel.isHidden = false
        }
        else {
            frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // We know the destination of the segue is the Navigation Controller
    let navigationController = segue.destination as! UINavigationController
    // We know the Navigation Controller only contains a Creation View Controller
    let creationController = navigationController.topViewController as! CreationViewController
        
    // We set the flashcardsController property to self
    creationController.flashcardsController = self
    }
}

