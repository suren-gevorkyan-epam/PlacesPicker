//
//  PlacesListViewModel.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import Foundation
import UIKit.UITableView

protocol PlacesListViewModelDelegate: AnyObject {
    func reloadData()
    func showLoading()
    func hideLoading()
    func fetchingFailed(withError error: String?)
    func showAlert(withTitle title: String, message: String)
}

class PlacesListViewModel: NSObject {
    let placesLoader: PlacesLoader
    private(set) var content = [Place]()

    weak var delegate: PlacesListViewModelDelegate?

    var navigationTitle: String { "Places to visit" }

    init(placesLoader: PlacesLoader) {
        self.placesLoader = placesLoader
    }

    func configureTableView(_ tableView: UITableView) {
//        tableView.registerNibCell(PlaceTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PlaceTableViewCell.nib, forCellReuseIdentifier: PlaceTableViewCell.reuseIdentifier)
    }

    func fetchData() {
        delegate?.showLoading()

        placesLoader.loadPlaces { [weak self] places, error in
            if let places = places {
                self?.content = places
                self?.delegate?.hideLoading()
                self?.delegate?.reloadData()
            } else {
                self?.delegate?.fetchingFailed(withError: error)
            }
        }
    }
}

extension PlacesListViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueNibCell(PlaceTableViewCell.self) { }

        if let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.reuseIdentifier) as? PlaceTableViewCell {
            let place = content[indexPath.row]
            let vm = PlaceTableViewCellViewModel(title: place.name, iconName: place.imageName)
            cell.setup(withViewModel: vm)
            return cell
        }
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let place = content[indexPath.row]
        delegate?.showAlert(withTitle: place.name, message: place.description)
    }
}
