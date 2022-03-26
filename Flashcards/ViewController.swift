//
//  ViewController.swift
//  Flashcards
//
//  Created by Sam Mucyo on 2/26/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapFlashcard = UITapGestureRecognizer(target: self, action: #selector(didTapFlashcard(_:)) )
        tapFlashcard.numberOfTapsRequired = 1
        tapFlashcard.numberOfTouchesRequired = 1
        
        frontLabel.addGestureRecognizer(tapFlashcard)
        backLabel.addGestureRecognizer(tapFlashcard)
        backLabel.isUserInteractionEnabled = true
        frontLabel.isUserInteractionEnabled = true
        
        // Read Saved flashcard if needed
        readSavedFlashcards()
        
        // Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "NAME TWO WORDS:  ACCORDING TO DONALD KNUTH, IT IS THE ROOT OF ALL EVIL.", answer: "PREMATURE OPTIMIZATION")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    @IBAction func didTapFlashcard(_ sender: Any) {
        if frontLabel.isHidden {
            frontLabel.isHidden = false
        }
        else {
            frontLabel.isHidden = true
        }
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    
    @IBAction func didTapPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    
    @IBAction func didTapNext(_ sender: Any) {
        
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons() {
        
        // Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        // Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }

    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to Dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer]
        }
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log it
        print("🥳 Flashcards savedd to UserDefaults")
    }
    func readSavedFlashcards() {
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard (question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
        // Put all these cards in our flashcareds array
            flashcards.append(contentsOf: savedCards)
        }
    }

    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        flashcards.append(flashcard)
        
        // Logging to the console
        print("😄 Added new flashcard.")
        print("😄 We now have \(flashcards.count) flashcards")
        print("😄 Added new flashcard.")
        
        // Update current index
        currentIndex = flashcards.count - 1
        print("😄 Our current index is \(currentIndex)")
    
        // Update Labels
        updateLabels()
        // Update buttons
        updateNextPrevButtons()
        
        saveAllFlashcardsToDisk()
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

