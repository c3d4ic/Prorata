//
//  DetailSessionViewController.swift
//  Prorata
//
//  Created by Cédric Chabaud on 10/01/2022.
//

import UIKit

class DetailSessionViewController: UIViewController {

    
    @IBOutlet weak var ParticipantTableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var segmentSelected : Int {
        return segmentControl.selectedSegmentIndex
    }
    
    var session: Session = .init(participants: [], expenses: [], title: "Demo")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParticipantTableView.delegate = self
        ParticipantTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    private func showAlert(title : String, message: String, actionType: Int) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
            alert.addTextField { (textField:UITextField) in
                if(actionType == 0) {
                    textField.placeholder = "Nom"
                } else {
                    textField.placeholder = "Titre"
                }
                textField.returnKeyType = .continue
            }
            alert.addTextField { (textField:UITextField) in
                textField.placeholder = "Apport"
                textField.returnKeyType = .continue
                textField.keyboardType = .decimalPad
            }
       
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                      
                    guard let textFields = alert.textFields,
                          textFields.count >= 2,
                          let name = textFields.first?.text,
                          let pay = textFields[1].text,
                          let amount = Double(pay)
                    else {
                        return
                    }

                    if(actionType == 0) {

                        let participant = Participant(name: name, pay: amount)
                        self.session.participants.append(participant)
                    } else {
                        let expense = Expense(title: name, amount: amount)
                        self.session.expenses.append(expense)
                    }
                    self.segmentControl.selectedSegmentIndex = actionType
                    self.ParticipantTableView.reloadData()
                }))

                
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
     }
    
    
    @IBAction func addParticipant(_ sender: Any) {
        showAlert(title: "Titre", message: "Message", actionType: 0)
    }
    
    @IBAction func addExpense(_ sender: Any) {
        showAlert(title: "Titre", message: "Message", actionType: 1)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        ParticipantTableView.reloadData()
    }
}

extension DetailSessionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentSelected == 0) {
            return session.participants.count
        } else {
            return session.expenses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if(segmentSelected == 0) {
            let participant = session.participants[indexPath.row]
            cell.textLabel?.text = participant.name
        } else {
            let expense = session.expenses[indexPath.row]
            cell.textLabel?.text = String(expense.amount)
            cell.detailTextLabel?.text = "toto"
        }
        return cell
    }
f
}

