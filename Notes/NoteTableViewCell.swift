//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Глеб Фандеев on 23.03.2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(object: Note) {
        self.descriptionLabel.text = object.description
        self.titleLabel.text = object.title
    }

}
