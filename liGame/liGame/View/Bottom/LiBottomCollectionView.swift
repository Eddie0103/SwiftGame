//
//  LiBottomCollectionView.swift
//  liGame
//
//  Created by pjhubs on 2019/9/8.
//  Copyright © 2019 翁培钧. All rights reserved.
//

import UIKit

class LiBottomCollectionView: UICollectionView {

    var longTap: ((Puzzle) -> ())?

    let cellIdentifier = "PJLineCollectionViewCell"
    var viewModels = [Puzzle]()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initView() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        isUserInteractionEnabled = true
        dataSource = self
        
        register(LiBottomCollectionViewCell.self, forCellWithReuseIdentifier: "LiBottomCollectionViewCell")
    }
}

extension LiBottomCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiBottomCollectionViewCell", for: indexPath) as! LiBottomCollectionViewCell
        cell.viewModel = viewModels[indexPath.row]
        // TODO: 有问题。修改完后会走两次
        cell.index = indexPath.row
        cell.longTap = { [weak self] index in
            guard let self = self else { return }
            self.longTap?(self.viewModels[index])
            self.viewModels.remove(at: index)
            self.reloadData()
        }
        return cell
    }
}