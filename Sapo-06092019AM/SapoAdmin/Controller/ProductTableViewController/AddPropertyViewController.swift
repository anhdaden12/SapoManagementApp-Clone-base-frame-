//
//  AddPropertyViewController.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class AddPropertyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let array = ["Kích thước","Màu sắc","Chất liệu"]
    var arrayShowContent = ["Kích thước"]
    
    var dictionaryAttributes  = Dictionary<String, [String]>()
    var hideAddPropertyCell: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        //Add rightBarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_integrate_dsp_info_check"), style: .plain, target: self, action: #selector(didTapSaveProperty))
        
        // Custom Back Item
        navigationController?.navigationBar.backIndicatorImage = nil
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = nil
        navigationItem.leftItemsSupplementBackButton = true
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backButton
    }
    
    fileprivate func getValueInEachCell() {
        for i in 0..<arrayShowContent.count {
            let cell = tableView.cellForRow(at: [0,i]) as! DetailPropertyCell
            if let string = cell.listAttributedTextField.text {
                let arrayString = string.components(separatedBy: ",")
                if let property = cell.propertyTextField.text {
                    dictionaryAttributes[property] = arrayString.map{$0.trimmingCharacters(in: .whitespaces)}
                }
            }
        }
    }
    
    @objc func didTapSaveProperty() {
        getValueInEachCell()
        
        showAddProductWithPropertyVC()
    }
    
    fileprivate func showAddProductWithPropertyVC() {
        let addProductWithPropertyVC: AddProductWithPropertyTableVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "addProductWithPropertyTableVC") as! AddProductWithPropertyTableVC
        addProductWithPropertyVC.dictionaryAttributes = dictionaryAttributes
        show(addProductWithPropertyVC, sender: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dictionaryAttributes = Dictionary<String, [String]>()
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrayShowContent.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    fileprivate func assignDelegateForCellInSection1(_ cell: DetailPropertyCell, _ tableView: UITableView, _ indexPath: IndexPath) {
        if arrayShowContent.count == 1 {
            cell.callBack = {
                self.arrayShowContent[0] = ""
                tableView.reloadData()
            }
        } else {
            cell.callBack = {
                self.arrayShowContent.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if self.arrayShowContent.count < 3 {
                    self.hideAddPropertyCell = false
                }
                tableView.reloadSections(IndexSet.init(integer: 1), with: .none)
                tableView.reloadSections(IndexSet.init(integer: 0), with: .none)
            }
        }
    }
    
    fileprivate func assignDelegateForCellInSection2(_ cell: AddPropertyCell, _ tableView: UITableView) {
        switch arrayShowContent.count {
        case 1:
            cell.delegate = {
                self.arrayShowContent.append(self.array[1])
                tableView.insertRows(at: [[0,1]], with: .left)
                tableView.reloadSections(IndexSet.init(integer: 1), with: .none)
            }
        case 2:
            cell.delegate = {
                self.arrayShowContent.append(self.array[2])
                self.hideAddPropertyCell = true
                tableView.insertRows(at: [[0,2]], with: .left)
                tableView.reloadSections(IndexSet.init(integer: 1), with: .none)
            }
        default:
            tableView.reloadSections(IndexSet.init(integer: 1), with: .none)
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailPropertyCell", for: indexPath) as! DetailPropertyCell
            cell.propertyTextField.text = arrayShowContent[indexPath.row]
            assignDelegateForCellInSection1(cell, tableView, indexPath)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "addPropertyCell", for: indexPath) as! AddPropertyCell
            assignDelegateForCellInSection2(cell, tableView)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        default:
            if hideAddPropertyCell {
                return 0
            } else {
                return 60
            }
        }
    }
}
