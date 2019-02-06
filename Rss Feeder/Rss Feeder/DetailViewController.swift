//
//  DetailViewController.swift
//  Rss Feeder
//
//  Created by Dan on 2/6/19.
//  Copyright © 2019 Dan Viitenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var rssItem: Rss?
    
    @IBOutlet weak var rssImageView: UIImageView!
    @IBOutlet weak var rssTitleLabel: UILabel!
    @IBOutlet weak var rssTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateOutlets()
    }
    func updateOutlets(){
        rssTitleLabel.text = rssItem?.title
        rssTextView.text = rssItem?.description
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.sync {
            guard let url = URL(string: (rssItem?.urlImage)!) else { return }
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async {
                    self.rssImageView.image = UIImage(data: data)
                }
            }
        }
    }
}
