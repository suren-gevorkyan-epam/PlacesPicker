//
//  PlacesPickerTests.swift
//  PlacesPickerTests
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import Quick
import Nimble
import Foundation
import UIKit.UITableView

class PlacesPickerTests: QuickSpec {
    private var tableView = UITableView()
    private var placesLoader: PlacesLoader!
    private var viewModel: PlacesListViewModel!
    private var vmDelegate: PlacesListViewModelDelegateMock!

    override func spec() {
        describe("Places Picker") {
            beforeEach {
                self.placesLoader = PlacesLoaderMock()
                self.viewModel = PlacesListViewModel(placesLoader: self.placesLoader)

                self.vmDelegate = PlacesListViewModelDelegateMock()
                self.viewModel.delegate = self.vmDelegate
            }

            describe("UITableView configuration") {
                context("configure tableview") {
                    it("delegate and datasource are set") {
                        self.viewModel.configureTableView(self.tableView)
                        expect(self.tableView.delegate).toNot(beNil())
                        expect(self.tableView.dataSource).toNot(beNil())
                        expect(self.tableView.numberOfRows(inSection: 0)).to(be(0))
                    }
                }
                context("when beforeEach is called") {
                    it("ViewModel delegate is set") {
                        expect(self.viewModel.delegate).toNot(beNil())
                    }
                }
            }

            describe("when fetchData is called") {
                beforeEach {
                    self.viewModel.fetchData()
                }

                it("show loading is called") {
//                    expect(self.vmDelegate.action).to(be(PlacesListViewModelDelegateMock.Action.showLoading))
                }
            }
        }
    }
}

fileprivate class PlacesLoaderMock: PlacesLoader {
    private static let placesFileName = "landmarkData.json"

    func loadPlaces(completion: @escaping ([Place]?, _ error: String?) -> Void) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            do {
                let places = try PlacesLoaderMock.loadFromFile()
                completion(places, nil)
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
    }

    private static func loadFromFile() throws -> [Place] {
        let data: Data

        guard let file = Bundle.main.url(forResource: placesFileName, withExtension: nil) else {
            fatalError("Couldn't find \(placesFileName) in main bundle.")
        }

        data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode([Place].self, from: data)
    }
}

fileprivate class PlacesListViewModelDelegateMock: PlacesListViewModelDelegate {
    enum Action {
        case initial
        case reloadData
        case showLoading
        case hideLoading
        case fetchingFailed
        case showAlert
    }

    private(set) var action = Action.initial

    func reloadData() {
        action = .reloadData
    }

    func showLoading() {
        action = .showLoading
    }

    func hideLoading() {
        action = .hideLoading
    }

    func fetchingFailed(withError error: String?) {
        action = .fetchingFailed
    }

    func showAlert(withTitle title: String, message: String) {
        action = .showAlert
    }
}
