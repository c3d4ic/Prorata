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
                alert.addTextField { (textField:UITextField) in
                    textField.placeholder = "Janvier 2022"
                    textField.returnKeyType = .continue
                }
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    guard let textFields = alert.textFields,
                          textFields.count >= 1,
                          let title = textFields.first?.text
                    else {
                        return
                    }
                                        
                    let session: Session = .init(participants: [], expenses: [], title: title)
                    self.sessions.append(session)
                    self.SessionTableView.reloadData()
                    
                }))
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
     }
   
      
    @IBAction func addSession(_ sender: Any) {
        showAlert()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "detailpop", let next = segue.destination as?
//            DetailSessionViewController {
//            next.session = sender as? Session
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailpop" {
            if let destination = segue.destination as? DetailSessionViewController {
                if let data = sender as? Session {
                    destination.session = data
                } else {
                    fatalError("Pas de session trouvé");
                }
                
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailpop", sender: sessions[indexPath.item])
    }
}
