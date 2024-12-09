//
//  KingFisher.swift
//  MiniProject
//
//  Created by hendra on 08/12/24.
//

import Kingfisher

internal class CacheImageManager {
    static func configureKingfisherCache() {
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 50 * 1024 * 1024
        cache.diskStorage.config.sizeLimit = 100 * 1024 * 1024
        cache.diskStorage.config.expiration = .seconds(600)
    }

}
