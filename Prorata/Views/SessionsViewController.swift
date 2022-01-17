//
//  SessionsViewController.swift
//  Prorata
//
//  Created by Kingama Jordy on 08.01.22.
//

import UIKit

class SessionsViewController: UIViewController {

    @IBOutlet weak var SessionTableView: UITableView!
    var sessions: [Session] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SessionTableView.delegate = self
        SessionTableView.dataSource = self
    }
    
    private func showAlert() {
         let alert = UIAlertController(title: "Alert", message: "Veuillez renseigner le nom de la session", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Janvier 2022"
            field.returnKeyType = .continue
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: addSession))
         present(alert, animated: true)
     }
    
    private func addSession(alert: UIAlertAction) {
        // JE DOIS RECCUPERER LE TEXT FIELD DE L'ALERT ET L'AJOUTER DANS LE TABLE VIEW
    }
     
    @IBAction func addSession(_ sender: Any) {
        showAlert()
    }
    
}

extension SessionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let session = sessions[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = session.title
        return cell
    }
    
    
}
