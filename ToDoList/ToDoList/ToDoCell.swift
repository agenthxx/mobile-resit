//
//  ToDoCell.swift
//  ToDoList
//
//  Created by BP-36-201-18 on 12/02/2026.
//

import UIKit
protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoCell)
}
class ToDoCell: UITableViewCell {
        
    weak var delegate: (ToDoCellDelegate)?
    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var titleOfTodo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completedButtonTapped(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
}
