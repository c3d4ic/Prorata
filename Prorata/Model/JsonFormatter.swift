//
//  JsonFormatter.swift
//  Prorata
//
//  Created by Cédric Chabaud on 01/07/2021.
//

import Foundation

class JSonFormatter {
    
    func parse(fileName: String, ext: String, completion: (([Budget]) -> Void)?) {
        if let file = Bundle.main.url(forResource: fileName, withExtension: ext) {
            do {
                let jsonData = try Data(contentsOf: file)
                let budgets = try JSONDecoder().decode([Budget].self, from: jsonData)
                completion?(budgets)
            } catch {
                print(error.localizedDescription)
                completion?([])
            }
        } else {
            print("Ne peut pas récupérer Json depuis le fichier")
            completion?([])
        }
    }
    
}
