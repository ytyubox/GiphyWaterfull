//
//  ViewController.swift
//  YuPracticeGIF
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
  var length: [IndexPath:CGFloat] = [:]
  let giphy = Giphy()
  var urls:[URL] = []
  var cache:[IndexPath:Data] = [:]
  var re:GiphyResponse!

  override func viewDidLoad() {
    super.viewDidLoad()
    if let layout = collectionView?.collectionViewLayout as? GiphyWaterFallLayout {
      layout.delegate = self
    }

    collectionView?.backgroundColor = .clear
    collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)

  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    collectionView.delegate = self
    collectionView.dataSource = self
    giphy.loadGiphyTread {[weak self] (result) in
      guard let self = self else {return}
      switch result{
      case .error(let error):
        print("Error loading:" + error.localizedDescription)
      case .results(let data):
        print(data.prettyPrintedJSONString ?? "error")
        guard let res = GiphyResponse(from: data) else {return}
        self.re = res
        self.urls = res.getURL(for: .fixWidth)
        DispatchQueue.main.async {self.collectionView.reloadData()}
      }
    }
  }
}

extension ViewController{
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return urls.count
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GIFCollectionViewCell
    cell.backgroundColor = .red
    let url = urls[indexPath.item]
    if let olddata =  cache[indexPath]{
      cell.imageView.loadGIF(data: olddata)
      self.collectionView.collectionViewLayout.invalidateLayout()
    }
    else{
    DispatchQueue.global().async { [weak self] in

      guard
        let self = self,
        let data = try? Data(contentsOf: url) else {fatalError("error load GIF")}
      self.cache[indexPath] = data
//      self.length[indexPath] = 
      cell.imageView.loadGIF(data: data)
      }
    }
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    return CGSize(width: itemSize, height: itemSize)
  }
}
extension ViewController: WaterfallLayoutDelegate {

  func collectionView(_ collectionView: UICollectionView,
                      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    let array = re.getleng(for: .fixWidth)
    let length = array[indexPath.item] ?? 300
    return CGFloat(length)
  //FIXME: get height from data not from json
  }
}

