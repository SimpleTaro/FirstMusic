//
//  MusicPlayer.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/23.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicPlayer: MusicPlayerAdmin {
    
    //プレイリストを更新
    func updatePlaylist() {
        let query = MPMediaQuery.songs()
        if var allSongs = query.items {
            let songCount = allSongs.count
            NSLog(String(allSongs.count))
            playlist = [MPMediaItem](allSongs[0..<songCount])
        }
    }
    
    func play(number: Int) {
        if 0 <= number && number < playlist.count {
            player.nowPlayingItem = playlist[number]
            player.play()
        }
    }
}
