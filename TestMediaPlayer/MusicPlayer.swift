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
    
    //全アーティスト取得
    func updateArtistlist() {
        let query = MPMediaQuery.artists()
        var allArtist = query.collections
        let artistCount = allArtist?.count
        artistPlaylist = [MPMediaItemCollection](allArtist![0..<artistCount!])
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
    
    //アーティスト一覧画面から選択されたアーティストの曲を取得する
    func updateArtistAlbumMusiclist(artistName: String) {
        for i in 0..<artistPlaylist.count {
            if artistPlaylist[i].representativeItem?.albumArtist == artistName {
                playlist += artistPlaylist[i].items
            }
        }
    }
    
    // シャッフルされたプレイリストを作成する
    func updateSufflePlaylist() {
        let query = MPMediaQuery.songs()
        var allSongs = query.items
        let songCount = allSongs?.count
        var tmpPlaylist = [MPMediaItem](allSongs![0..<songCount!])
        shufflePlaylist(array: &tmpPlaylist)
        playlist = tmpPlaylist
    }
    
    // プレイリストをシャッフル
    func shufflePlaylist( array: inout [MPMediaItem]) {
        let max = array.count
        for no in (0...max*2) {
            let i = no % max
            let j = Int(arc4random_uniform(UInt32(max)))
            if i != j {
                swap(&array[i], &array[j])
            }
        }
    }
}
