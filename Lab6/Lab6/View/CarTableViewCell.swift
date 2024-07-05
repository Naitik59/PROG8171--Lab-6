//
//  CarTableViewCell.swift
//  Lab6
//
//  Created by Naitik Ratilal Patel on 05/07/24.
//

import UIKit

// CarTableViewCell
class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var modelAndStyleLbl: UILabel!
    
    // Configure cell to change data in "cellForRowAt"
    func configureCell(image: String, brand: String, model: String, style: String) {
        self.carImg.image = UIImage(named: image)
        self.brandLbl.text = brand
        self.modelAndStyleLbl.text = "\(model), \(style)"
    }
}
