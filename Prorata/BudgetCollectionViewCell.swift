//
//  BudgetCollectionViewCell.swift
//  Prorata
//
//  Created by Cédric Chabaud on 01/07/2021.
//

import UIKit

class BudgetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var budgetImageView: UIImageView!
    @IBOutlet weak var budgetTitle: UILabel!
    @IBOutlet weak var budgetUsers: UILabel!
    @IBOutlet weak var budgetTotal: UILabel!

    var urlString: String! {
        didSet {
            budgetImageView.loadFrom(urlString)
        }
    }
}
