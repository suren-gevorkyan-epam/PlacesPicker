//
//  PlacesListViewController.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import UIKit

class PlacesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    private var viewModel: PlacesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let loader = NetworkPlacesLoader()
        viewModel = PlacesListViewModel(placesLoader: loader)
        viewModel.delegate = self

        title = viewModel.navigationTitle
        viewModel.configureTableView(tableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.fetchData()
    }
}

extension PlacesListViewController: PlacesListViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }

    func fetchingFailed(withError error: String?) {

    }

    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
