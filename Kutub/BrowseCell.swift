//
//  BrowseCell.swift
//  Kutub
//
//  Created by Ali Mir on 12/7/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class BrowseCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var featuredCategoryName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    internal var books = [BrowsingBook]()
    internal var spotlights = [Spotlight]()
    internal var cellType: FeaturedItem!
    
    func configureCell(of type: FeaturedItem, title: String, books: [BrowsingBook], spotlights: [Spotlight]) {
        setCollectionViewDataSourceDelegate(delegate: self, dataSource: self)
        featuredCategoryName.setTitle(title + " >", for: .normal)
        self.cellType = type
        self.books = books
        self.spotlights = spotlights
    }

    internal func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate, S: UICollectionViewDataSource>(delegate: D, dataSource: S) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellType == .books {
            return books.count
        } else if cellType == .spotlights {
            return spotlights.count
        } else {
            return 0
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellType == .books {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "booksCollectionCell", for: indexPath)
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "spotlightsCollectionCell", for: indexPath)
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let booksCollectionCell = cell as? BooksCollectionCell {
            let bookTitle = books[indexPath.item].title
            let authors = books[indexPath.item].authors
            booksCollectionCell.configureCell(title: bookTitle, authorNames: authors)
        } else {
            if let spotlightsCollectionCell = cell as? spotlightsCollectionViewCell {
                spotlightsCollectionCell.configureCell(image: #imageLiteral(resourceName: "testImage"))
            }
        }
    }
}
