//
//  AddProductWithPropertyVC.swift
//  SapoAdmin
//
//  Created by Trương Quang on 8/29/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

class AddProductWithPropertyTableVC: UITableViewController {
    
    @IBOutlet weak var descriptionProductTxt: JumpTextField!
    @IBOutlet weak var nameOfItem: JumpTextField!
    
    var descriptionProductText: String?
    
    let imagePicker = UIImagePickerController()
    var choosenImage: UIImage?
    
    var dictionaryAttributes = Dictionary<String, [String]>()
    var arrayShow = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Thêm sản phẩm"
        
        imagePicker.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        appendElementIntoArrayShow()
        
        // Customize left bar Item
        let customBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "CloseIcon"), style: .plain, target: self, action: #selector(goToProductTBVC))
        navigationItem.leftBarButtonItem = customBackButton
        
        // Right bar Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_integrate_dsp_info_check"), style: .plain, target: self, action: #selector(didTapSaveProperty))
        
    }
    
    @objc func didTapSaveProperty() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveFromAddProductWithPropertyVC"), object: nil, userInfo: nil)
    }
    
    @objc func goToProductTBVC() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        if let descriptionProductText = self.descriptionProductText {
            self.descriptionProductTxt.text = descriptionProductText
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "passArrayShow"), object: arrayShow, userInfo: nil)
        tableView.reloadSections(IndexSet.init(integer: 3), with: .none)
    }
    
    fileprivate func appendElementIntoArrayShow() {
        let arrayValueProperty = Array(dictionaryAttributes.values)
        switch arrayValueProperty.count {
        case 1:
            for i in arrayValueProperty[0] {
                arrayShow.append(i)
            }
        case 2:
            for i in arrayValueProperty[0] {
                for j in arrayValueProperty[1] {
                    let text = "\(i) - \(j)"
                    arrayShow.append(text)
                }
            }
        case 3:
            for i in arrayValueProperty[0] {
                for j in arrayValueProperty[1] {
                    for k in arrayValueProperty[2] {
                        let text = "\(i) - \(j) - \(k)"
                        arrayShow.append(text)
                    }
                }
            }
        default:
            break
        }
    }
    
    @IBAction func chooseImageForItem(_ sender: Any) {
        chooseImage()
    }
    
    func chooseImage() {
        let alertController = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        
        let fromCamera = UIAlertAction(title: "From camera", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                showAlert(title: "Error", message: "Thiết bị không có camera!", vc: self)
            }
        }
        
        let fromLibrary = UIAlertAction(title: "From library", style: .default) { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(fromCamera)
        alertController.addAction(fromLibrary)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    enum SegueIdentifier : String {
        case mieuTa = "mieuTa"
        case showProductAttribute = "showProductAttribute"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? PopUpShowEditVC else {return}
        vc.delegateShowEditView = {
            let addProductWithPropertyVC: AddPropertyViewController = UIStoryboard(name: "ProductAttribute", bundle: nil).instantiateViewController(withIdentifier: "AddPropertyViewController") as! AddPropertyViewController
            addProductWithPropertyVC.dictionaryAttributes = self.dictionaryAttributes
            self.dismiss(animated: true, completion: nil)
            self.show(addProductWithPropertyVC, sender: nil)
        }
        let po = vc.popoverPresentationController
        po?.delegate = self
        
        switch segue.identifier ?? "" {
        case SegueIdentifier.mieuTa.rawValue:
            let vc = vc as! DescriptionProductVC
            vc.descriptionProduct = descriptionProductTxt.text
        case SegueIdentifier.showProductAttribute.rawValue:
            return
        default:
            return
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func didTapDescriptionProductBtn(_ sender: Any) {
        let descriptionProductVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "descriptionProductVC") as! DescriptionProductVC
        descriptionProductVC.descriptionProduct = descriptionProductTxt.text
        show(descriptionProductVC, sender: nil)
    }
    
    // MARK: Set height for row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1, 2:
            return 60
        default:
            let heightForDetailProductTBV = 75 * arrayShow.count
            let heightForDetailProductTBVCell = CGFloat(heightForDetailProductTBV + 45)
            return heightForDetailProductTBVCell
        }
    }
}

extension AddProductWithPropertyTableVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        choosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        NotificationCenter.default.post(name: .passDataToCollectionViewCell, object: choosenImage)
        dismiss(animated: true, completion: nil)
        choosenImage = nil
    }
}

extension AddProductWithPropertyTableVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


