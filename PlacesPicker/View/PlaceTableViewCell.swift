//
//  PlaceTableViewCell.swift
//  PlacesPicker
//
//  Created by Suren Gevorkyan on 23.06.21.
//

import UIKit

class PlaceTableViewCell: NibTableViewCellBase {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        chevronImageView.image = UIImage(
            systemName: "chevron.right",
            withConfiguration: UIImage.SymbolConfiguration(weight: .heavy)
        )
    }

    func setup(withViewModel viewModel: PlaceTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        iconView.image = UIImage(named: viewModel.iconName)
    }
}
