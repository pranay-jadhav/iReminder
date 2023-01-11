//
//  GoalsCollectionCell.swift
//  iReminder
//
//  Created by Pranay Jadhav  on 10/01/23.
//

import UIKit

protocol GoalsCollectionCellDelegate: AnyObject {
    func createNewGoal(indexPath: IndexPath)
}

class GoalsCollectionCell: UITableViewCell,
                           UICollectionViewDelegate,
                           UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var goalsCollectionView: UICollectionView!
    
    private var goalsDataSource = [Activity]()
    weak var delegate: GoalsCollectionCellDelegate?
    private var indexPath: IndexPath?
    
    //MARK: - Configure Cell UI
    func configureCell(data: [Activity], indexPath: IndexPath) {
        self.indexPath = indexPath
        self.goalsDataSource = data
        self.selectionStyle = .none
        goalsCollectionView.delegate = self
        goalsCollectionView.dataSource = self
        
        let goalsCollectionViewCell = UINib(nibName: "GoalsCollectionViewCell", bundle: nil)
        goalsCollectionView.register(goalsCollectionViewCell,
                                     forCellWithReuseIdentifier: "GoalsCollectionViewCell")
        self.goalsCollectionView.reloadData()
    }
    
    //MARK: - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let goalsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsCollectionViewCell", for: indexPath) as! GoalsCollectionViewCell
        goalsCollectionViewCell.configureCell(data: self.goalsDataSource[indexPath.row])
        return goalsCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.goalsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: goalsCollectionView.frame.width * 0.8,
                      height: goalsCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.createNewGoal(indexPath: indexPath)
    }
}
