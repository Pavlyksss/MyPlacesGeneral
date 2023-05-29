//
//  NewPlacesTableViewController.swift
//  MyPlaces
//
//  Created by Сергій Павлик on 24.05.2023.
//

import UIKit

class NewPlacesTableViewController: UITableViewController {
    
    
    @IBOutlet weak var imageOfPlaces: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Скривает лишние полоски ячейки
        //tableView.tableFooterView = UIView()
        
    }
    
    //При нажатии на екран ячейка скривается
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let cameraIcon = #imageLiteral(resourceName: "CameraIcon")
            let photoIcon = #imageLiteral(resourceName: "CameraIcon")
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }

    
}

// MARK: TextFieldDelegate
extension NewPlacesTableViewController: UITextFieldDelegate {
    
    //Скриваем клавиатуру по нажанитию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

//MARK: Work with image
extension NewPlacesTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker,animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfPlaces.image = info[.editedImage] as? UIImage
        imageOfPlaces.contentMode = .scaleToFill
        imageOfPlaces.clipsToBounds = true
        dismiss(animated: true)
    }
    
}
