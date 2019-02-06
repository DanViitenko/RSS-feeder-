//
//  ViewController.swift
//  Rss Feeder
//
//  Created by Dan on 2/6/19.
//  Copyright © 2019 Dan Viitenko. All rights reserved.
//

import UIKit
import FeedKit

class RSSViewController: UIViewController {
    var rssItems = [Rss]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        makeRss()
    }
    
    func makeRss(){
        let feedURL = URL(string: "https://www.liga.net/tech/all/rss.xml")!
        let parser = FeedParser(URL: feedURL)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            print(result.isSuccess)
            switch result {
            case let .rss(feed):
                feed.items?.forEach({ (feedItem) in
                    let createModel = Rss(feedItem: feedItem)
                    
                    self.rssItems.append(createModel)
                })
            case let .failure(error):
                print("Failed \(error)")
                break
            default:
                print("Found...")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail", let indexPath = tableView.indexPathForSelectedRow, let detailViewController = segue.destination as? DetailViewController, rssItems.indices.contains(indexPath.row){
            detailViewController.rssItem = rssItems[indexPath.row]
        }
    }
}

extension RSSViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "rssCell", for: indexPath) as! TableViewCell
        let selectRow = rssItems[indexPath.row]
        cell.titleLabel.text = selectRow.title
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.sync {
            guard let url = URL(string: selectRow.urlImage!) else { return }
            if let data = try? Data(contentsOf: url){
                cell.imageViewCell.image = UIImage(data: data)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    
}


