//
//  File.swift
//  Notes
//
//  Created by Глеб Фандеев on 23.03.2022.
//

import Foundation


struct Note {
    var title: String
    var description : String
}

var notes = [Note]()

// MARK: - Data saving model between sessions

func saveData() {
    var titlesArray = [String]()
    var descriptionsArray = [String]()
    for note in notes {
        titlesArray.append(note.title)
        descriptionsArray.append(note.description)
    }
    UserDefaults.standard.set(titlesArray, forKey: "titles")
    UserDefaults.standard.set(descriptionsArray, forKey: "descriptions")
    UserDefaults.standard.synchronize()
}

func loadData() {
    if let titlesArray = UserDefaults.standard.array(forKey: "titles") as? [String], let descriptionArray = UserDefaults.standard.array(forKey: "descriptions") as? [String] {
        notes = []
        for idx in titlesArray.indices {
            notes.append(Note(title: titlesArray[idx], description: descriptionArray[idx]))
        }
    } else {
        notes = []
    }
}

