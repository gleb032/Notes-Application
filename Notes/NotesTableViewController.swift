//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Глеб Фандеев on 23.03.2022.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        if (notes.count==0) {
            notes.append(Note(title: "Example", description: "Hey!"))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editNote" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let note = notes[indexPath.row]
        let noteVC = segue.destination as! NoteViewController
        noteVC.note = note
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NoteViewController
        let note = sourceVC.note
        
        // if this was old one, then just save changes in it
        if let indexPath = tableView.indexPathForSelectedRow {
            notes[indexPath.row] = note
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: notes.count, section: 0)
            notes.append(note)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        saveData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        
        let selectedCell: Note! = notes[indexPath.row]
        cell.set(object: selectedCell)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveData()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let selectedNote = notes.remove(at: fromIndexPath.row)
        notes.insert(selectedNote, at: to.row)
        tableView.reloadData()
        saveData()
    }
}
