//
//  ViewController.swift
//  shop-dialog
//
//  Created by Yan Cheng Cheok on 16/04/2022.
//

import UIKit

var shops = [
    Shop(title: "Combo", description: "Combo short description"),
    Shop(title: "Color", description: "Start Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. End"),
    Shop(title: "Recording", description: "Recording short description"),
    Shop(title: "Print PDF", description: "Start Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. End"),
    Shop(title: "Another shop", description: "Another long description. Another long description. Another long description. Another long description. Another long description. Another long description. "),
    Shop(title: "Calendar", description: "Calendar short description"),
    Shop(title: "Combo2", description: "Combo short description"),
    Shop(title: "Color2", description: "Start Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. Color long description. End"),
    Shop(title: "Recording2", description: "Recording short description"),
    Shop(title: "Print PDF2", description: "Start Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. Print PDF long description. End"),
    Shop(title: "Another shop2", description: "Another long description. Another long description. Another long description. Another long description. Another long description. Another long description. "),
    Shop(title: "Calendar2", description: "Calendar short description"),
]

var isExpanded = Array(repeating: false, count: shops.count)

class ViewController: UIViewController {

    let PADDING = CGFloat(8.0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private func getLayout() -> UICollectionViewCompositionalLayout {
        // https://stackoverflow.com/questions/69120818/uicollectionviewcompositionallayout-dynamic-height-uicollectionview-cell-what
        
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // Group
        let groupSize = itemSize
        //let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        group.interItemSpacing = .fixed(0)
        
        let section = NSCollectionLayoutSection(group: group)
        // Spacing for collection view's leading & trailing & bottom. For top, it is the spacing between header and item
        section.contentInsets = NSDirectionalEdgeInsets(
            top: PADDING * 2,
            leading: PADDING,
            bottom: PADDING * 2,
            trailing: PADDING
        )
        // Vertical spacing between cards within different group.
        section.interGroupSpacing = PADDING
        
        let compositionalLayout = UICollectionViewCompositionalLayout(section: section)
        
        return compositionalLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewCell = CollectionViewCell.getUINib()
        collectionView.register(collectionViewCell, forCellWithReuseIdentifier: "cell")
        
        collectionView.collectionViewLayout = getLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        
        let shop = shops[indexPath.item]
        
        collectionViewCell.title.text = shop.title
        collectionViewCell._description.text = shop.description
        
        if isExpanded[indexPath.item] {
            collectionViewCell.innerView.isHidden = false
        } else {
            collectionViewCell.innerView.isHidden = true
        }
        
        return collectionViewCell
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in (0..<isExpanded.count) {
            if i == indexPath.item {
                // ensure always visible
                isExpanded[i] = true
            } else {
                // set all other rows to false
                isExpanded[i] = false
            }
            if let c = collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? CollectionViewCell {
                c.innerView.isHidden = !isExpanded[i]
            }
        }
        collectionView.performBatchUpdates(nil, completion: nil)
    }
}

