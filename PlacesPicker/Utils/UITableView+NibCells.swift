//
//  UITableView+NibCells.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import UIKit

extension UITableView {
    func registerNibCell<T: NibTableViewCellBase>(_ type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueNibCell<T: NibTableViewCellBase>(_ type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T
    }
}
