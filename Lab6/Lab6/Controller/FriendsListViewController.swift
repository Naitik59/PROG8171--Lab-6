//
//  ViewController.swift
//  Lab6
//
//  Created by Naitik Ratilal Patel on 05/07/24.
//

import UIKit

class FriendsListViewController: UIViewController, AddFriendViewControllerDelegate {
    
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var editSwitch: UISwitch!
    
    var friends: [Friend] = [friend1, friend2, friend3, friend4, friend5, friend6, friend7, friend8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureSwitch()
    }
    
    private func setupView() {
        
        friendsTableView.register(FriendTableViewCell.nib(), forCellReuseIdentifier: FriendTableViewCell.identifier)
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.separatorStyle = .none
    }
    
    private func configureSwitch() {
        editSwitch.addTarget(self, action: #selector(switchOnOff), for: .valueChanged)
    }
    
    @objc func switchOnOff(_ sender: UISwitch) {
        friendsTableView.setEditing(sender.isOn, animated: true)
    }
    
    // navigate to AddFriendViewController on add button tap
    @IBAction func navigateToAddFriend(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddFriendViewController") as! AddFriendViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // delegate function of AddFriendViewControllerDelegate
    func add(_ friend: Friend) {
        self.friends.append(friend)
        DispatchQueue.main.async {
            self.friendsTableView.reloadData()
        }
    }
}

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.identifier, for: indexPath) as! FriendTableViewCell
        
        let friend = friends[indexPath.row]
        cell.configureCell(firstName: friend.firstName, mobile: friend.mobile, email: friend.email, city: friend.city, sport: friend.sport, food: friend.food)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = friends.remove(at: sourceIndexPath.row)
        friends.insert(movedItem, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
