//
//  SettingsViewController.swift
//  Tinder
//
//  Created by Oleg Kudimov on 3/20/21.
//

import UIKit

class CustomImagePickerController: UIImagePickerController {
    
    var imageButton: UIButton?
}

class SettingsController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    lazy var image1Button = createButton(selector: #selector(handlePhotoSelect))
    lazy var image2Button = createButton(selector: #selector(handlePhotoSelect))
    lazy var image3Button = createButton(selector: #selector(handlePhotoSelect))
    
    
    @objc fileprivate func handlePhotoSelect(button: UIButton) {
        print("Select photo with button:", button)
        
        let imagePicker = CustomImagePickerController()
        imagePicker.delegate = self
        imagePicker.imageButton = button
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[.originalImage] as? UIImage
        let imageButton = (picker as? CustomImagePickerController)?.imageButton
        imageButton?.setImage(selectedImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func createButton(selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true 
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNavigationItems()
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        //disable horizontal lines
        tableView.tableFooterView = UIView()
        
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        //header.backgroundColor = .blue
        
        header.addSubview(image1Button)
        let padding: CGFloat = 16
            
        image1Button.anchor(top: header.topAnchor, leading: header.leadingAnchor, bottom: header.bottomAnchor, trailing: nil, padding: .init(top: padding, left: padding, bottom: padding, right: 0))
        image1Button.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.45).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [image2Button, image3Button])
        stackView.axis = .vertical
        
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        
        header.addSubview(stackView)
        stackView.anchor(top: header.topAnchor, leading: image1Button.trailingAnchor, bottom: header.bottomAnchor, trailing: header.trailingAnchor, padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    
    fileprivate func settingNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleCancel)),
            UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleCancel))
        ]
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true , completion: nil)
    }
}
