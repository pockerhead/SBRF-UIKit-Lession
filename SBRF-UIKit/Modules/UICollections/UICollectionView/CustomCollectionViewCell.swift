//
//  CustomCollectionViewCell.swift
//  SBRF-UIKit
//
//  Created by Artem Balashov on 22/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    private func configureUI() {
        
    }
    
    override func layoutSubviews() {
        
    }
    
}
