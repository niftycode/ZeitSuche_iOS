//
//  SearchResultCell.swift
//  ZeitSuche
//
//  Created by Bodo Schönfeld on 22/06/16.
//  Copyright © 2016 Bodo Schönfeld. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    // IB outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // The awakeFromNib() method is called after this cell object has been loaded 
    // from the nib but before the cell is added to the table view.
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255,
                                               blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
