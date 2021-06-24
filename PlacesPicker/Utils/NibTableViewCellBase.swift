//
//  NibTableViewCellBase.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import UIKit

class NibTableViewCellBase: UITableViewCell {
    class var reuseIdentifier: String { String(describing: self) }
    class var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
}
