//
//  ViewController.swift
//  Prorata
//
//  Created by Cédric Chabaud on 11/06/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var budgetCollectionView: UICollectionView!
    
    var budgets: [Budget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        budgetCollectionView.delegate = self
        budgetCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 300)
        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 30
        budgetCollectionView.collectionViewLayout = layout
        
            
        
        

        JSonFormatter().parse(fileName: "budget", ext: "json") { (budgets) in
            self.budgets = budgets
            self.budgetCollectionView.reloadData()

        }
        
        
    }

    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection : ", budgets.count)
        return budgets.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let budget = budgets[indexPath.item]
               print("cellForItemAt : ", budget)
               let cell = budgetCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BudgetCollectionViewCell
               cell.urlString = budget.picture.large
               return cell
    }
    
}

