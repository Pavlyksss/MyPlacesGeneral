//
//  TableViewController.swift
//  MyPlaces
//
//  Created by Сергій Павлик on 03.05.2023.
//

import UIKit
import RealmSwift


class TableViewController: UITableViewController {
    


//    let places = [Places(name: "Burger Heroes", location: "Kiev", type: "Cafe", image: "Burger Heroes")]
    
    var places: Results<Place>!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.isEmpty ? 0 : places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]



        cell.nameLabelOU.text = place.name
        cell.locationLabelOU.text = place.location
        cell.typeLabelOU.text = place.type
        cell.imageOfPlaceOU.image = UIImage(data: place.imageData!)

        cell.imageOfPlaceOU.layer.cornerRadius = cell.imageOfPlaceOU.frame.size.height / 2

        cell.imageOfPlaceOU.clipsToBounds = true


        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    //MARK:
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let place = places[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") {_,_,_ in
            StorageManager.deleteObject(place: place)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return deleteAction
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }




//     Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath:
     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlacesTableViewController
            newPlaceVC.currentPlace = place
        }
    }


    @IBAction func unwindSeque(_ seque: UIStoryboardSegue){
        guard let newPlaceVC = seque.source as? NewPlacesTableViewController else { return }
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }
    

}
