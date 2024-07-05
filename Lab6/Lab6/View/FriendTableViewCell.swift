//
//  FriendTableViewCell.swift
//  Lab6
//
//  Created by Naitik Ratilal Patel on 05/07/24.
//

import UIKit

// Custome FriendTableViewCell
class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var sportLbl: UILabel!
    @IBOutlet weak var foodLbl: UILabel!
    
    // identifier and nib to register cell in table view
    static let identifier: String = "FriendTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // Configure cell to change data in "cellForRowAt"
    func configureCell(firstName: String, mobile: String, email: String, city: String, sport: String, food: String) {
        self.firstNameLbl.text = firstName
        self.mobileLbl.text = mobile
        self.emailLbl.text = email
        self.cityLbl.text = city
        self.sportLbl.text = sport
        self.foodLbl.text = food
    }
}
