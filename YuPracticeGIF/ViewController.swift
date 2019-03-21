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

  override func viewDidLoad() {
    super.viewDidLoad()

  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    giphy.loadGiphyTread { (result) in
      switch result{
      case .error(let error):
        print("Error loading:" + error.localizedDescription)
      case .results(let data):
//        print(data.prettyPrintedJSONString ?? "error")
        guard let res = GiphyResponse(from: data) else {return}
        print(res.getURL(for: .height))
      }
    }
  }
}
