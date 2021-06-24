//
//  NetworkPlacesLoader.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import Foundation

class NetworkPlacesLoader: PlacesLoader {
    private static let placesFileName = "landmarkData.json"

    func loadPlaces(completion: @escaping ([Place]?, _ error: String?) -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(1)) {
            do {
                let places = try NetworkPlacesLoader.loadFromFile()
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
