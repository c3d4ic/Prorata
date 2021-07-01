//
//  ImageExtension.swift
//  Prorata
//
//  Created by Cédric Chabaud on 01/07/2021.
//

import UIKit

extension UIImageView {
    
    func loadFrom(_ urlString: String) {
        //Vérifie si cette string est une url
        guard let url = URL(string: urlString) else { return }
        //Lancement URLSession
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //Vérifier si erreur
            if let err = error {
                print(err.localizedDescription)
            }
            //Verifier si data
            if let d = data {
                //Convertir data en image
                let image = UIImage(data: d)
                //Revenir sur le main
                DispatchQueue.main.async {
                    //Attribuer l'image
                    self.image = image
                }
            }
        }.resume()
    }
    
}
