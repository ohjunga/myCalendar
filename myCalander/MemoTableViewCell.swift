//
//  MemoTableViewCell.swift
//  myCalander
//
//  Created by junga oh on 2022/08/16.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet weak var memoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
