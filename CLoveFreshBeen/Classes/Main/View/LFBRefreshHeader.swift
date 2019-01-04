//
//  LFBRefreshHeader.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import MJRefresh

class LFBRefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        stateLabel.isHidden = false
        lastUpdatedTimeLabel.isHidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], for: .idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], for: .pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], for: .refreshing)
        
        setTitle("下拉刷新", for: .idle)
        setTitle("松手开始刷新", for: .pulling)
        setTitle("正在刷新", for: .refreshing)
    }
}
