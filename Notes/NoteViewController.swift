//
//  ViewController.swift
//  Notes
//
//  Created by Глеб Фандеев on 23.03.2022.
//
//

import UIKit

class NoteViewController: UIViewController {
    
    var note = Note(title: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSaveButtonState()
    }
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteDescription: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // if the note has no title, then save button is not available
    private func updateSaveButtonState() {
        let titleText = noteTitle.text ?? ""
        saveButton.isEnabled = !titleText.isEmpty
    }
    
    private func updateUI() {
        noteTitle.text = note.title
        noteDescription.text = note.description
    }
    
    @IBAction func titleChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        
        let title = noteTitle.text ?? ""
        let description = noteDescription.text ?? ""
        
        self.note = Note(title: title, description: description)
    }

}

