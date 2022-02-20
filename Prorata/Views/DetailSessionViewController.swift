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
    
    func createField(alert: UIAlertController, placeholder: String, value: String) -> UIAlertController {
 
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = placeholder
            textField.returnKeyType = .continue
            textField.text = value
        }
        
        return alert
    }
    
    private func showAlert(fields : [Field], editMode: Bool, actionType: Int, index: Int? = nil) {
        
        
        var alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        
        for field in fields {
            alert = createField(alert: alert, placeholder: field.placeholder, value: field.value)
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
                if(editMode) {
                    // update le field
                    if let indexParticipant = index {
                        self.session.participants[indexParticipant].name = name
                        self.session.participants[indexParticipant].pay = amount
                    }
                   
                } else {
                    let participant = Participant(name: name, pay: amount, owe: 0, percent: 0)
                    self.session.participants.append(participant)
                }

                
            } else {
                
                if(editMode) {
                    if let indexParticipant = index {
                        self.session.expenses[indexParticipant].title = name
                        self.session.expenses[indexParticipant].amount = amount
                    }
                } else {
                    let expense = Expense(title: name, amount: amount)
                    self.session.expenses.append(expense)
                }
            }
            
            
            if(!self.session.participants.isEmpty && !self.session.expenses.isEmpty) {
                self.calculeProrata()
            }
            
            self.segmentControl.selectedSegmentIndex = actionType
            self.DetailTableView.reloadData()
        }))

        
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
       
        
                
     }
    
    private func calculeProrata() {
        for (index, item) in session.participants.enumerated() {
            var participant = item
            participant.percent = round(participant.pay / session.sumParticipants * 100) / 100.0
            participant.owe = round(participant.percent * session.sumExpenses * 100) / 100.0
            session.participants[index] = participant
        }
    }
     
    
    @IBAction func addParticipant(_ sender: Any) {
        
        let titleField = Field(placeholder: "Nom du participant", value: "")
        let amountField = Field(placeholder: "Valeur", value: "")
        let arrayOfFields = [titleField, amountField]

        showAlert(fields: arrayOfFields, editMode: false, actionType: 0)
    }
    
    @IBAction func addExpense(_ sender: Any) {
        
        let titleField = Field(placeholder: "Nom de la dépense", value: "")
        let amountField = Field(placeholder: "Valeur", value: "")
        let arrayOfFields = [titleField, amountField]

        showAlert(fields: arrayOfFields, editMode: false, actionType: 1)
        
    }
    
    private func editParticipant(value1: String, value2: String, index: Int){
        let titleField = Field(placeholder: "Nom du participant", value: value1)
        let amountField = Field(placeholder: "Valeur", value: value2)
        let arrayOfFields = [titleField, amountField]

        showAlert(fields: arrayOfFields, editMode: true, actionType: 0, index: index)
    }
    
    private func editExpense(value1: String, value2: String, index: Int) {
        let titleField = Field(placeholder: "Nom de la dépense", value: value1)
        let amountField = Field(placeholder: "Valeur", value: value2)
        let arrayOfFields = [titleField, amountField]

        showAlert(fields: arrayOfFields, editMode: true, actionType: 1, index: index)
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
            let item = session.participants[indexPath.item]
            editParticipant(value1: item.name, value2: String(item.pay), index: indexPath.item)
        } else {
            let item = session.expenses[indexPath.item]
            editExpense(value1: item.title, value2: String(item.amount), index: indexPath.item)

        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DetailTableView.beginUpdates()
            if(segmentSelected == 0) {
                session.participants.remove(at: indexPath.row)
            } else {
                session.expenses.remove(at: indexPath.row)
            }
            DetailTableView.deleteRows(at: [indexPath], with: .fade)
            self.calculeProrata()
            self.DetailTableView.reloadData()
            DetailTableView.endUpdates()
        }
    }
  
    
  

}



