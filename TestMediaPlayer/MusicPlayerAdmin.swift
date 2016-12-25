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
    var playlist = [MPMediaItem]() {
        didSet {
            playlistToQueue()
        }
    }
    
    //プレイリストを再生キューにセット
    func playlistToQueue() {
        if playlist.isEmpty == false {
            let collection = MPMediaItemCollection(items: playlist)
            player.setQueue(with: collection)
        } else {
            player.stop()
        }
    }
}
