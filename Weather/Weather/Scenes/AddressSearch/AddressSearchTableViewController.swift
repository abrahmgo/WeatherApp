//
//  AddressSearchTableViewController.swift
//  Weather
//
//  Created by Andrés Bonilla Gómez on 12/10/24.
//

import UIKit
import Utils
import MapKit

protocol AddressSearchTableViewDelegate: AnyObject {
    func selectLocation(location: CLLocationCoordinate2D)
}

class AddressSearchTableViewController: UITableViewController {
        
    var matchingItems: [MKMapItem] = []
    weak var delegate: AddressSearchTableViewDelegate?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: AddressSearchTableViewController.typeName, bundle: Bundle(for: type(of: self)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matchingItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedItem = matchingItems[indexPath.row].placemark
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = selectedItem.name
        cell?.detailTextLabel?.text = selectedItem.country
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = matchingItems[indexPath.row].placemark.coordinate
        delegate?.selectLocation(location: location)
    }
}

extension AddressSearchTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            dump(error)
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
