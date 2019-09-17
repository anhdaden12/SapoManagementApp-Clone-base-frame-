//
//  TableViewCell.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/6/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var myImageCollectionView: UICollectionView!
    
    var listImage = [UIImage]()
    
    var estimateWidth: CGFloat = 120
    var miniLineSpacing: CGFloat = 10
    var miniInteritemSpacing: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(addImage), name: .passDataToCollectionViewCell, object: nil)
        setGrid()
    }
    
    @objc func addImage(notification: Notification) {
        let image = notification.object as! UIImage
        listImage.append(image)
        myImageCollectionView.reloadData()
        setGrid()
    }
    
    // Set Grid
    func setGrid() {
        let layout = myImageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = miniLineSpacing
        layout.minimumInteritemSpacing = miniInteritemSpacing
        
        let width = calculateWidth()
        layout.itemSize = CGSize(width: width, height: width)
        
    }
    func calculateWidth() -> CGFloat {
        return 80.00
    }//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageItem.image = listImage[indexPath.row]
        return cell
    }
    
    
}
