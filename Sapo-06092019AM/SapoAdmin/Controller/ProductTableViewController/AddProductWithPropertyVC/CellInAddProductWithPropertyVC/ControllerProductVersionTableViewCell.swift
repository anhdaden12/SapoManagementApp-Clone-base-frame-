//
//  ControllerProductVersionTableViewCell.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/30/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class ControllerProductVersionTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var detailProductVersionTBVCell: UITableView!
    
    var arrayShow = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        detailProductVersionTBVCell.delegate = self
        detailProductVersionTBVCell.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getArrayShow), name: NSNotification.Name("passArrayShow"), object: nil)
        
    }
    
    @objc func getArrayShow(notification: Notification) {
        let array = notification.object as! Array<String>
        arrayShow = array
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailProductVersionTableViewCell
        cell.nameOfProductVersion.text = arrayShow[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
