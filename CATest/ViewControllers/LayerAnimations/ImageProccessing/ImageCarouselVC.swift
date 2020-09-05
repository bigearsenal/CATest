//
//  ImageCarouselVC.swift
//  CATest
//
//  Created by Chung Tran on 9/2/20.
//  Copyright © 2020 Chung Tran. All rights reserved.
//

import Foundation
import UIKit

class ImageCarouselVC: BaseViewController, UICollectionViewDataSource {
    let imagePaths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Vacation Photos")
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
        layout.scrollDirection = .horizontal
        
        let myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.backgroundColor = UIColor.white
        return myCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagePaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if cell.contentView.viewWithTag(1) as? UIImageView == nil {
            cell.contentView.subviews.forEach {$0.removeFromSuperview()}
            let imageView = UIImageView(forAutoLayout: ())
            imageView.tag = 1
            cell.contentView.addSubview(imageView)
            imageView.autoPinEdgesToSuperviewEdges()
        }
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(contentsOfFile: imagePaths[indexPath.row])
        
        return cell
    }
}
