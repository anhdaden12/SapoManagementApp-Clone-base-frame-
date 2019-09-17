//
//  AddProductTableVC.swift
//  SapoAdmin
//
//  Created by Ngoc on 8/5/19.
//  Copyright © 2019 Minh Thang. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let passActionFromPickImage = Notification.Name(rawValue: "passActionFromPickImage")
    static let passDataToCollectionViewCell = Notification.Name(rawValue: "passDataToCollectionViewCell")
}

class AddProductTableVC: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet weak var descriptionProductTxt: JumpTextField!
    @IBOutlet weak var lblRetailPrice: UILabel!
    @IBOutlet weak var lblWholeSalePrice: UILabel!
    @IBOutlet weak var lblImportPrice: UILabel!
    @IBOutlet weak var nameOfItem: UITextField!
    
    @IBOutlet weak var labelBarcode: UITextField!
    
    var descriptionProductText: String?
    
    var retailPrice: Int = 0
    var wholeSalePrice: Int = 0
    var importPrice: Int = 0
    
    let imagePicker = UIImagePickerController()
    var choosenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Custom Back ButtonItem
        let backButton = UIBarButtonItem.init(title: " ", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "BackIcon")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "BackIcon")
        
        NotificationCenter.default.addObserver(self, selector: #selector(assignDescriptionProduct(notification:)), name: NSNotification.Name(rawValue: "postFromDescriptionProductVC"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        if let descriptionProductText = self.descriptionProductText {
            self.descriptionProductTxt.text = descriptionProductText
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameOfItem.becomeFirstResponder()
    }
    
    @objc func assignDescriptionProduct(notification: Notification) {
        let decrpt = notification.object as! String
        descriptionProductText = decrpt
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "postFromDescriptionProductVC"), object: nil)
    }
    
    // Quang lam
    @IBAction func chooseImageForItem(_ sender: Any) {
        chooseImage()
    }
    
    
    //Choose Image
    func chooseImage() {
        let alertController = UIAlertController(title: "Choose image from", message: nil, preferredStyle: .actionSheet)
        
        //From camera
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
        
        //From library
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
    
    @IBAction func scanBarCode(_ sender: Any) {
        let scanVC = storyboard?.instantiateViewController(withIdentifier: "CsanView") as! CsanViewController
        NotificationCenter.default.addObserver(self, selector: #selector(updateBarcode), name: .passValueBarCode, object: nil)
        present(scanVC, animated: true, completion: nil)
    }
    
    @objc func updateBarcode(notification: Notification) {
        let barcode = notification.object as! String
        labelBarcode.text = barcode
        NotificationCenter.default.post(name: UITextField.textDidBeginEditingNotification, object: self.labelBarcode)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    enum SegueIdentifier : String {
        case giaBanLe = "giabanle"
        case giaBanBuon = "giabanbuon"
        case giaNhap = "gianhap"
        case mieuTa = "mieuTa"
        case showProductAttribute = "showProductAttribute"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        let vc = segue.destination
        
        switch segue.identifier ?? "" {
        case SegueIdentifier.giaBanLe.rawValue:
            let vc = vc as! NumpadViewController
            setupNumpadPopover(vc: vc, priceValue: retailPrice, title: "Giá bán lẻ")
            vc.callback = { number in
                self.retailPrice = number
                self.lblRetailPrice.text = number.delimiter
            }
            
            
        case SegueIdentifier.giaBanBuon.rawValue:
            let vc = vc as! NumpadViewController
            setupNumpadPopover(vc: vc, priceValue: wholeSalePrice, title: "Giá bán buôn")
            vc.callback = { number in
                self.wholeSalePrice = number
                self.lblWholeSalePrice.text = number.delimiter
            }
            
            
        case SegueIdentifier.giaNhap.rawValue:
            let vc = vc as! NumpadViewController
            setupNumpadPopover(vc: vc, priceValue: importPrice, title: "Giá nhập")
            vc.callback = { number in
                self.importPrice = number
                self.lblImportPrice.text = number.delimiter
            }
            
        case SegueIdentifier.mieuTa.rawValue:
            let vc = vc as! DescriptionProductVC
            vc.descriptionProduct = descriptionProductTxt.text
        case SegueIdentifier.showProductAttribute.rawValue:
            return
        default:
            return
        }
    }
    
    private func setupNumpadPopover(vc: NumpadViewController, priceValue: Int? = nil, title: String? = nil) {
        vc.title = title
        if let priceValue = priceValue {
            vc.displayNumber = priceValue
        }
    }
    
    
    @IBAction func onCLickCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Add Property
extension AddProductTableVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
