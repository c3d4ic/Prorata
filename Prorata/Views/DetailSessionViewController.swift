//
//  DetailSessionViewController.swift
//  Prorata
//
//  Created by Cédric Chabaud on 10/01/2022.
//

import UIKit

class DetailSessionViewController: UIViewController {

    
    @IBOutlet weak var DetailTableView: UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var segmentSelected : Int {
        return segmentControl.selectedSegmentIndex
    }
    
 
    var session: Session = .init(participants: [], expenses: [], title: "Demo")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
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

                        let participant = Participant(name: name, pay: amount, owe: 0, percent: 0)
                        self.session.participants.append(participant)
                    } else {
                        let expense = Expense(title: name, amount: amount)
                        self.session.expenses.append(expense)
                    }
                    if(self.session.participants.count > 0 && self.session.expenses.count > 0) {
                        self.calculeProrata()
                    }
                    
                    self.segmentControl.selectedSegmentIndex = actionType
                    self.DetailTableView.reloadData()
                }))

                
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
     }
    
    func calculeProrata() {
        
        /*
         diviser chaque salaire par le total des salaires des participants
         multiplier le % par la somme total a payer et on a le resultat
         */
        
        var sumPay : Double = 0
        var sumExpense : Double = 0

        for participant in session.participants {
            // Je reccupère la somme de tout les salaires
            sumPay += participant.pay
        }
        
        for expense in session.expenses {
            // Je reccupère la somme de toute les dépenses
            sumExpense += expense.amount
        }
        
        for participant in session.participants.indices {
            session.participants[participant].percent = session.participants[participant].pay / sumPay
            session.participants[participant].owe = session.participants[participant].percent * sumExpense
            
        }
    }
    
    
    @IBAction func addParticipant(_ sender: Any) {
        showAlert(title: "Titre", message: "Message", actionType: 0)
    }
    
    @IBAction func addExpense(_ sender: Any) {
        showAlert(title: "Titre", message: "Message", actionType: 1)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        DetailTableView.reloadData()
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
            cell.detailTextLabel?.text = String(participant.owe)
        } else {
            let expense = session.expenses[indexPath.row]
            cell.textLabel?.text = String(expense.amount)
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(segmentSelected == 0) {
            print(session.participants[indexPath.item])
            showAlert(title: "Titre", message: "Message", actionType: 0)
            
        } else {
            showAlert(title: "Titre", message: "Message", actionType: 1)

            print(session.expenses[indexPath.item])

        }
    }

}



