//
//  ViewController.swift
//  YuPracticeGIF
//
//  Created by 游宗諭 on 2019/3/21.
//  Copyright © 2019 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

  let giphy = Giphy()
  var urls:[URL] = []

  override func viewDidLoad() {
    super.viewDidLoad()

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
//        print(data.prettyPrintedJSONString ?? "error")
        guard let res = GiphyResponse(from: data) else {return}
        self.urls = res.getURL(for: .height)
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
    DispatchQueue.global().async {
      guard let data = try? Data(contentsOf: url) else {fatalError("error load GIF")}
      cell.imageView.loadGIF(data: data)
    }
    return cell
  }
}
