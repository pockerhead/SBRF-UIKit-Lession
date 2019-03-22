//
//  CustomCollectionViewCell.swift
//  SBRF-UIKit
//
//  Created by Artem Balashov on 22/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func configureUI() {
        addSubview(label)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
    }
    
    override func layoutSubviews() {
        label.center = center
        label.frame = bounds
    }
    
}
