//
//  SBRFUIKitCollectionViewController.swift
//  SBRF-UIKit
//
//  Created by Artem Balashov on 22/03/2019.
//  Copyright © 2019 pockerhead. All rights reserved.
//

import UIKit

class SBRFUIKitCollectionViewController: UIViewController {
    
    let layout = WaterfallBouncesLayout()
    
    lazy var collectionView: UICollectionView = {
        layout.delegate = self
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layout.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.frame = self.view.frame
    }
}

extension SBRFUIKitCollectionViewController: UICollectionViewDelegate {
    
}

extension SBRFUIKitCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomCollectionViewCell.self), for: indexPath) as? CustomCollectionViewCell {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.red.cgColor
            cell.label.text = "\(indexPath.row)"

            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
    }
    
    
}

extension SBRFUIKitCollectionViewController: WaterfallBouncesLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 3 == 0 { return 170 }
        return indexPath.row % 5 == 0 ? 250 : 190
    }
    
    
}
