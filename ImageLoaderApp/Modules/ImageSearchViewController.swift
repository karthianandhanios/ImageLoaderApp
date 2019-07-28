//
//  ViewController.swift
//  ImageLoaderApp
//
//  Created by Karthi Anandhan on 27/07/19.
//  Copyright © 2019 karthi. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    private let sectionInsets = UIEdgeInsets(top: 10.0,
                                             left: 10,
                                             bottom: 10.0,
                                             right: 10)
    private let itemsPerRow: CGFloat = 3
    let reuseIdentifier = "photoCollectionViewCell"
    var imageViewModel : ImageSearchViewModel?
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 20))
    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewModel = ImageSearchViewModel()
        
        searchBar.placeholder = "Your placeholder"
        
        var leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        searchBar.delegate = self
        imageSearchCollectionView.dataSource = self
        imageSearchCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       searchAndUpateData(searchText: searchText)
    }
    private func searchAndUpateData(searchText :String){
        imageViewModel?.searchImage(for: searchText, completion: {
            DispatchQueue.main.async {
                self.imageSearchCollectionView.reloadData()
            }
        })
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewModel?.imageSearchResult.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        let result = imageViewModel?.imageSearchResult[indexPath.row]
        cell.backgroundColor = .black
        cell.imageView.downloaded(from: result?.imageUrl)
       // cell.imageView.image = UIImagetit.init(named: "test_image")
        // Configure the cell
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("index path row ---->",indexPath.row , "imageSearchResult count -->",imageViewModel?.imageSearchResult.count)
        if indexPath.row == (imageViewModel?.imageSearchResult.count ?? 0) / 3  {  //numberofitem count
            updateNextSet()
        }
    }
    private func updateNextSet(){
        if  let text = searchBar.text {
            searchAndUpateData(searchText: text)
        }
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
