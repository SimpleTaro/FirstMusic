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
    
    //全曲取得プレイリストを更新
    func updatePlaylist() {
        let query = MPMediaQuery.songs()
        if var allSongs = query.items {
            let songCount = allSongs.count
            NSLog(String(allSongs.count))
            playlist = [MPMediaItem](allSongs[0..<songCount])
        }
    }
    
    //全アルバム取得プレイリストを更新
    func updateAlbumlist() {
        let query = MPMediaQuery.albums()
        var allAlbums = query.collections
        let albumCount = allAlbums?.count
        albumPlaylist = [MPMediaItemCollection](allAlbums![0..<albumCount!])
    }
    
    //選択されたセルの曲を再生する
    func play(number: Int) {
        if 0 <= number && number < playlist.count {
            player.nowPlayingItem = playlist[number]
            player.play()
        }
    }
    
    //選択されたセルのアルバムをプレイリストに更新
    func updateAlbumPlaylist(number: Int) {
        if 0 <= number && number < albumPlaylist.count {
            playlist = albumPlaylist[number].items
        }
    }
}
