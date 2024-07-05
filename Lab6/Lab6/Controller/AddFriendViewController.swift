//
//  AddFriendViewController.swift
//  Lab6
//
//  Created by Naitik Ratilal Patel on 05/07/24.
//

import UIKit

protocol AddFriendViewControllerDelegate: AnyObject {
    func add(_ friend: Friend)
}

class AddFriendViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var foodTextField: UITextField!
    
    weak var delegate: AddFriendViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
    }
    
    // setting up text field delegate
    private func setupTextField() {
        firstNameTextField.delegate = self
        mobileTextField.delegate = self
        emailTextField.delegate = self
        cityTextField.delegate = self
        sportTextField.delegate = self
        foodTextField.delegate = self
    }
    
    // clear form fields
    @IBAction func clearForm() {
        firstNameTextField.text = ""
        mobileTextField.text = ""
        emailTextField.text = ""
        cityTextField.text = ""
        sportTextField.text = ""
        foodTextField.text = ""
    }
    
    // add new friend
    @IBAction func addFriend() {
        // check for empty fields
        if (firstNameTextField.text == "" || mobileTextField.text == "" || emailTextField.text == "" || cityTextField.text == "" || sportTextField.text == "" || foodTextField.text == "") {
            presentAlert(errorMessage: "Oops, seems fields are empty")
        } else { // call delegate when all fields are filled
            let friend = Friend(firstName: firstNameTextField.text ?? "", mobile: mobileTextField.text ?? "", email: emailTextField.text ?? "", city: cityTextField.text ?? "", sport: sportTextField.text ?? "", food: foodTextField.text ?? "")
            self.delegate?.add(friend)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // present error alert
    private func presentAlert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertController, animated: true)
    }
}

// hide keyboard when return key pressed
extension AddFriendViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
