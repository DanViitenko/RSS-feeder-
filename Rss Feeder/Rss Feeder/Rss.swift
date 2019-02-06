//
//  Rss.swift
//  Rss Feeder
//
//  Created by Dan on 2/6/19.
//  Copyright © 2019 Dan Viitenko. All rights reserved.
//

import Foundation
import FeedKit

struct Rss {
    let title: String?
    let description: String?
    let urlImage: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title
        self.description = feedItem.description
        self.urlImage = feedItem.enclosure?.attributes?.url
    }
}
