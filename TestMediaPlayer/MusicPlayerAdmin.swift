//
//  MusicPlayerAdmin.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/23.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import Foundation
import MediaPlayer
import UIKit

class MusicPlayerAdmin: NSObject {
    
    let player = MPMusicPlayerController.systemMusicPlayer()
    //作成したプレイリスト
    var playlist = [MPMediaItem]()
    var playlistCollection = [MPMediaItemCollection]()
    
    //一時退避プレイリスト
    var historicalPlaylist = [MPMediaItem]()
    
    //全アルバムのプレイリスト
    var albumPlaylist = [MPMediaItemCollection]()
    
    //全アーティストのプレイリスト
    var artistPlaylist = [MPMediaItemCollection]()
    
    //プレイリストを再生キューにセット
    func playlistToQueue( playlist :[MPMediaItem]) {
        if playlist.isEmpty == false {
            let collection = MPMediaItemCollection(items: playlist)
            player.setQueue(with: collection)
        } else {
            player.stop()
        }
    }
    
    func clearQueue() {
        let tmpPlaylist : [MPMediaItem]? = []
        let tmpCollection = MPMediaItemCollection(items: tmpPlaylist!)
        player.setQueue(with: tmpCollection)
    }
    
    func clearQueue2(){
        let predicate = MPMediaPropertyPredicate()
        let q = MPMediaQuery()
        q.addFilterPredicate(predicate)
        player.setQueue(with: q)
        player.nowPlayingItem = nil
    }
    
    func clearQueue3(){
        let q = MPMediaQuery.init()
        player.setQueue(with: q)
    }
}
