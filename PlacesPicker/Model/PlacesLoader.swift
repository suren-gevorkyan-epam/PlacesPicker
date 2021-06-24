//
//  PlacesLoader.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import Foundation

protocol PlacesLoader {
    func loadPlaces(completion: @escaping ([Place]?, String?) -> Void)
}
