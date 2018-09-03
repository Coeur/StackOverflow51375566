//
//  ViewController.swift
//  StackOverflow51375566
//
//  Created by Antoine Cœur on 2018/9/3.
//  Copyright © 2018 coeur. All rights reserved.
//

import UIKit

func randomString(length: Int) -> String {
    let charArray: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
                                  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
                                  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let charArrayCount = UInt32(charArray.count)
    var randomString = ""
    for _ in 0 ..< length {
        randomString += String(charArray[Int(arc4random_uniform(charArrayCount))])
    }
    return randomString
}

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionLayout.estimatedItemSize = CGSize(width: 50, height: 25)
        collectionLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        for _ in 0 ..< 1000 {
            array.append(randomString(length: Int(arc4random_uniform(8))))
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = array[indexPath.row]
        return cell
    }
}

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
}

class AutoLayoutCollectionView: UICollectionView {
    
    private var reloadDataCompletionBlock: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        reloadDataCompletionBlock?()
        reloadDataCompletionBlock = nil
    }
    
    override func reloadData() {
        reloadDataCompletionBlock = { self.collectionViewLayout.invalidateLayout() }
        super.reloadData()
    }
}
