//
//  CarsListViewController.swift
//  Lab6
//
//  Created by Naitik Ratilal Patel on 05/07/24.
//

import UIKit

class CarsListViewController: UIViewController {
    
    @IBOutlet weak var carsTableView: UITableView!
    @IBOutlet weak var editSwitch: UISwitch!
    
    var cars: [Car] = [car1, car2, car3, car4, car5, car6, car7, car8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureSwitch()
    }
    
    private func setupView() {
        carsTableView.delegate = self
        carsTableView.dataSource = self
        carsTableView.separatorStyle = .none
    }
    
    // Configuring switch to perform action on ON/OFF
    private func configureSwitch() {
        editSwitch.addTarget(self, action: #selector(switchOnOff), for: .valueChanged)
    }
    
    @objc func switchOnOff(_ sender: UISwitch) {
        carsTableView.setEditing(sender.isOn, animated: true)
    }
    
    // Add button action that prompt alert that ask user to add car details
    @IBAction func addButtonAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Car", message: "Please enter car details.", preferredStyle: .alert)
            
            // adding text fields inside the alert
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter brand name"
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter model name"
            }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter style"
            }
            
            
            // alert action
            alertController.addAction(UIAlertAction(title: "Add", style: .cancel, handler: { _ in
                
                if let textFields = alertController.textFields {
                    let brand = textFields[0].text ?? ""
                    let model = textFields[1].text ?? ""
                    let style = textFields[2].text ?? ""
                    
                    // checking for empty fields
                    if (brand.isEmpty || model.isEmpty || style.isEmpty) {
                        self.presentAlert(errorMessage: "Oops, empty field passed.")
                    } else {
                        let car = Car(image: "911", model: model, brand: brand, style: style)
                        self.cars.append(car)
                        
                        DispatchQueue.main.async {
                            self.carsTableView.reloadData()
                        }
                    }
                }
            }))
            
            self.present(alertController, animated: true)
        }
    }
    
    // present alert for error
    private func presentAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertController, animated: true)
    }
}

extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        
        let car = cars[indexPath.row]
        cell.configureCell(image: car.image, brand: car.brand, model: car.model, style: car.style)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // setting editing style of table view
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    // allow to move row in table view
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // allow to delete row along with move option
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // perform changes when user move row in the table view
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = cars.remove(at: sourceIndexPath.row)
        cars.insert(movedItem, at: destinationIndexPath.row)
    }
    
    // perform changes when user deletes the row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cars.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
