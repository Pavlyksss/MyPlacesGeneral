//
//  TableViewController.swift
//  MyPlaces
//
//  Created by Сергій Павлик on 03.05.2023.
//

import UIKit

class TableViewController: UITableViewController {
    


//    let places = [Places(name: "Burger Heroes", location: "Kiev", type: "Cafe", image: "Burger Heroes")]
    
    var places = Place.getPlaces()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]


        
        cell.nameLabelOU.text = place.name
        cell.locationLabelOU.text = place.location
        cell.typeLabelOU.text = place.type
        
        if place.image == nil {
            cell.imageOfPlaceOU.image = UIImage(named: place.restaurantImage!)
        } else {
            cell.imageOfPlaceOU.image = place.image
        }
        
        
    
        
        cell.imageOfPlaceOU.layer.cornerRadius = cell.imageOfPlaceOU.frame.size.height / 2
        
        cell.imageOfPlaceOU.clipsToBounds = true

        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    



    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindSeque(_ seque: UIStoryboardSegue){
        guard let newPlaceVC = seque.source as? NewPlacesTableViewController else { return }
        
        newPlaceVC.saveNewPlace()
        places.append(newPlaceVC.newPlace!)
        tableView.reloadData()
    }
    

}
