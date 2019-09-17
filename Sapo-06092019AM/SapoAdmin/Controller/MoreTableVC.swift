//
//  MoreTableViewController.swift
//  SapoAdmin
//
//  Created by Minh Thang on 8/2/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit



class MoreTableVC: UIViewController {
    
    
    static var intance: MoreTableVC = {
        let storyborad = UIStoryboard(name: "More", bundle: nil)
        return storyborad.instantiateViewController(withIdentifier: "MoreTableVC") as! MoreTableVC
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var iconButton: UIBarButtonItem!
    
    static var modelsEdit: [AddModel] = [
        AddModel(name: "Tổng quan", image: #imageLiteral(resourceName: "ic_tab_bar_dashboard")),
        AddModel(name: "Đơn hàng", image: #imageLiteral(resourceName: "ic_tab_bar_order")),
        AddModel(name: "Sản phẩm", image: #imageLiteral(resourceName: "ic_tab_bar_product")),
        AddModel(name: "Báo cáo", image: #imageLiteral(resourceName: "ic_tab_bar_report")),
        AddModel(name: "Thông báo", image: #imageLiteral(resourceName: "ic_tab_bar_notification")),
        AddModel(name: "Đối tác", image: #imageLiteral(resourceName: "ic_tab_bar_partner"))
    ]
    
    
    var modelsEdit1: [AddModel] = [AddModel(name: "Cấu hình", image: #imageLiteral(resourceName: "ic_more_settings")),
                                   AddModel(name: "Hỗ trợ", image: #imageLiteral(resourceName: "ic_more_support"))
    ]
    
    enum SectionType: Int {
        case account
        case category
        case util
        case goToPos
        case logout
        case total
        
        func numberOfRow(isEdit: Bool) -> Int {
            switch self {
            case .category:
                return  isEdit ? 6 : 2
            case .util:
                return 2
            default:
                return 1
            }
        }
        
        var cellID: String {
            switch self {
                
            case .account:
                return "accountCell"
            case .goToPos:
                return "sapoPos"
            case .logout:
                return "logoutCell"
            default:
                return "categoryCell"
            }
        }
        var heightForFooterInSection: CGFloat {
            
            switch self {
            case .category:
                return 0
            default:
                return 20
            }
        }
        
        var heightForRow: CGFloat {
            switch self {
            case .account:
                return 82
            default:
                return 60
            }
        }
        
        var canmoveRowAt: Bool {
            
            switch self {
            case .category:
                return true
            default:
                return false
            }
        }
        
        func targetIndexPath(source: IndexPath, target: IndexPath) -> IndexPath {
            let condition = [0,2,3,4].contains(target.section)
            if condition {
                return source
            } else {
                return target
            }
        }
        
        func moverowAt(sourceIndex: IndexPath, destinationIndex: IndexPath) {
            var model: [AddModel] = modelsEdit
            let item = model[sourceIndex.row]
            model.remove(at: sourceIndex.row)
            model.insert(item, at: destinationIndex.row)
        }
        
    }
    
    
    
    
    var isEdit: Bool = false {
        didSet {
            iconButton.image = isEdit ? #imageLiteral(resourceName: "CloseIcon") : #imageLiteral(resourceName: "EditIcon")
            tableView.isEditing = isEdit
            let section = IndexSet.init(integer: 1)
            tableView.reloadSections(section, with: .automatic)
            tableView.reloadRows(at: [[0,0] as IndexPath], with: .none)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isEditing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadRows(at: [[0,0] as IndexPath], with: .none)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isEdit = false
    }
    
    @IBAction func editTapped(_ sender: Any) {
        self.isEdit = !isEdit
        let section = IndexSet.init(integer: 1)
        tableView.reloadSections(section, with: .automatic)
        
        tableView.reloadRows(at: [[0,0] as IndexPath], with: .none)
    }
    
}



extension MoreTableVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionType(rawValue: section)?.numberOfRow(isEdit: isEdit) ?? 0
    }
    
    
    fileprivate func stackViewTextandDetailConstraint(_ cell: UITableViewCell) {
        //set up stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 0
        
        stackView.addArrangedSubview(cell.textLabel!)
        stackView.addArrangedSubview(cell.detailTextLabel!)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(stackView)
        
        //constraint
        stackView.leadingAnchor.constraint(equalTo: cell.imageView!.trailingAnchor, constant: 10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: cell.imageView!.centerYAnchor, constant: 0).isActive = true
    }
    
    fileprivate func addAvatarConstraint(avatar: UIImageView, cell: UITableViewCell) {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        avatar.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor, constant: 0).isActive = true
        avatar.widthAnchor.constraint(equalTo: cell.imageView!.heightAnchor, multiplier: 1, constant: 0).isActive = true
        avatar.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 6).isActive = true
        avatar.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10).isActive = true
        
        avatar.layoutIfNeeded()
        avatar.layer.cornerRadius = 70 / 2
        avatar.contentMode = .scaleAspectFill
        avatar.layer.masksToBounds = true
    }
    
    fileprivate func addImageCOnstraint(_ cell: UITableViewCell) {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "ic_external_link")
        cell.contentView.addSubview(image)
       
        image.centerYAnchor.constraint(equalTo: cell.imageView!.centerYAnchor, constant: 0).isActive = true
        image.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10).isActive = true
        image.heightAnchor.constraint(equalTo: cell.imageView!.widthAnchor, multiplier: 1, constant: 0).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1).isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)!
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionType.cellID, for: indexPath)
        prepareForReuseCell(cell: cell)
        
        switch sectionType {
        case .account:
            let account = AppDelegate.shared.account
            if let avatarImageData = account?.avatarImage{
                
                cell.imageView?.image = UIImage(data: avatarImageData)
                
                // add constraint cho anh
                addAvatarConstraint(avatar: cell.imageView!, cell: cell)
                
            }
            
            cell.textLabel?.text = account?.name
            cell.detailTextLabel?.text = account?.email
            
            stackViewTextandDetailConstraint(cell)
            
        case .category:
            if isEdit {
                cell.textLabel?.text = MoreTableVC.modelsEdit[indexPath.row].name
                cell.imageView?.image = MoreTableVC.modelsEdit[indexPath.row].image
            } else {
                cell.textLabel?.text = MoreTableVC.modelsEdit[indexPath.row + 4].name
                cell.imageView?.image = MoreTableVC.modelsEdit[indexPath.row + 4].image
            }
        case .util:
            cell.textLabel?.text = modelsEdit1[indexPath.row].name
            cell.imageView?.image = modelsEdit1[indexPath.row].image
            
        case .goToPos:
            addImageCOnstraint(cell)
            //            cell.imageView?.image =  #imageLiteral(resourceName: "ic_order_dashboard_pos")
        //            cell.textLabel?.text = "Chuyển qua Sapo POS"
        case .logout:
            cell.separatorInset = UIEdgeInsets(top: 0, left: self.view.bounds.width, bottom: 0, right: 0)
            
        default:
            break
        }
        
        return cell
    }
    
    private func prepareForReuseCell(cell: UITableViewCell) {
        //        cell.imageView?.image = nil
        //        cell.textLabel?.text = ""
        //        cell.detailTextLabel?.text = ""
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SectionType(rawValue: section)?.heightForFooterInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SectionType(rawValue: indexPath.section)?.heightForRow ?? 0
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return SectionType(rawValue: indexPath.section)?.canmoveRowAt ?? false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        SectionType(rawValue: sourceIndexPath.section)?.moverowAt(sourceIndex: sourceIndexPath, destinationIndex: destinationIndexPath)
        reorderTabarController(sourceIndexPath, destinationIndexPath)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .groupTableViewBackground
        return footerView
    }
    
    func reorderTabarController(_ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) {
        let tabBarVC = tabBarController as! TabBarViewController
        var allViewController = tabBarVC.allViewController
        
        
        if sourceIndexPath.row <= 3 && destinationIndexPath.row <= 3 {
            let itemBar = allViewController[sourceIndexPath.row]
            allViewController.remove(at: sourceIndexPath.row)
            allViewController.insert(itemBar, at: destinationIndexPath.row)
            tabBarVC.allViewController = allViewController
        } else if sourceIndexPath.row > 3 && destinationIndexPath.row <= 3 {
            let itemTabBar = allViewController[sourceIndexPath.row + 1]
            allViewController.remove(at: sourceIndexPath.row + 1)
            allViewController.insert(itemTabBar, at: destinationIndexPath.row)
            let itemTabBarBeforeMoreTabBarItem = allViewController[4]
            allViewController.remove(at: 4)
            allViewController.insert(itemTabBarBeforeMoreTabBarItem, at: 5)
            tabBarVC.allViewController = allViewController
        } else if sourceIndexPath.row <= 3 && destinationIndexPath.row > 3 {
            let itemTabBar = allViewController[sourceIndexPath.row]
            allViewController.remove(at: sourceIndexPath.row)
            allViewController.insert(itemTabBar, at: destinationIndexPath.row + 1)
            let itemTabBarAfterMoreTabBarItem = allViewController[4]
            allViewController.remove(at: 4)
            allViewController.insert(itemTabBarAfterMoreTabBarItem, at: 3)
            tabBarVC.allViewController = allViewController
        } else {
            let itemTabBar = tabBarVC.allViewController[sourceIndexPath.row + 1]
            allViewController.remove(at: sourceIndexPath.row + 1)
            allViewController.insert(itemTabBar, at: destinationIndexPath.row + 1)
            tabBarVC.allViewController = allViewController
        }
    }
    
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return SectionType(rawValue: sourceIndexPath.section)?.targetIndexPath(source: sourceIndexPath, target: proposedDestinationIndexPath) ?? sourceIndexPath
    }
    
}

class MoreNavigationController: UINavigationController {
    
    static var instance : MoreNavigationController {
        let storyborad = UIStoryboard(name: "More", bundle: nil)
        return storyborad.instantiateViewController(withIdentifier: "MoreNavigationController") as! MoreNavigationController
    }
}


