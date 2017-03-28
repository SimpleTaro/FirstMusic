//
//  ViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/11/23.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    var player = MPMusicPlayerController()
    var musicPlayer = MusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        player = MPMusicPlayerController.systemMusicPlayer()
        
        // 再生中のItemが変わった時に通知を受ける
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.nowPlayingItemChanged(_:)), name: .MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        
        // 通知の有効化
        player.beginGeneratingPlaybackNotifications()
        
        //今流れている曲の情報を読み直す
        if let mediaItem = player.nowPlayingItem {
            updateSongInformationUI(mediaItem)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func upSwiped() {
        //MPMediaPickerControllerのインスタンスを作成
        let picker = MPMediaPickerController()
        //複数選択を可にする
        picker.allowsPickingMultipleItems = true
        //ピッカーのデリゲードを設定
        picker.delegate = self
        //ピッカーを表示する
        present(picker, animated: true, completion: nil)
    }
    
    //メディアアイテムピッカーを選択完了した時に呼び出される
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // プレイヤーを止める
        player.stop()
        //選択した曲情報がmediaItemCollectionに入っているので、これをplayerにセット
        player.setQueue(with: mediaItemCollection)
        // 選択した曲から最初の情報を表示
        let mediaItem = mediaItemCollection.items.first
        updateSongInformationUI(mediaItem!)
        // 選択した曲のinstanceを取得し、画面を閉じた状態でも音が再生されるようにする
        player.nowPlayingItem = mediaItem
        // プレイリストをリピート再生する
        player.repeatMode = MPMusicRepeatMode.all
        //再生開始
        player.play()
        //ピッカーを閉じ破棄する
        dismiss(animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        //ピッカーを閉じ破棄する
        dismiss(animated: true, completion: nil)
    }
    
    func nowPlayingItemChanged(_ notification: NSNotification){
        if let mediaItem = player.nowPlayingItem {
            updateSongInformationUI(mediaItem)
        }
    }
    
    // 音符ボタンが押させた時にプレイリストを更新する
    //@IBAction func selectMusic(_ sender: Any) {
    //    NSLog("updatePlaylist")
    //    NSLog(String(musicPlayer.playlistCollection.count))
    //    musicPlayer.updatePlaylistCollection()
    //    musicPlayer.playlistToQueue(playlist: musicPlayer.playlist)
    //}
    
    func updateSongInformationUI(_ mediaItem: MPMediaItem) {
        // 曲の情報表示
        // (a ?? b は、a != nil ? a! : bを示す演算子です)
        // (aがnilの場合にはbとなります)
        artistLabel.text = mediaItem.artist ?? "不明なアーティスト"
        albumLabel.text = mediaItem.albumTitle ?? "不明なアルバム"
        songLabel.text = mediaItem.title ?? "不明な曲"
        
        // アートワークの表示
        if let artwork = mediaItem.artwork {
            let image = artwork.image(at: imageView.bounds.size)
            imageView.image = image
        } else {
            // アートワークがない時
            // 今回は灰色にした
            imageView.image = nil
            imageView.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func pushPlayPause() {
        let playerStatus = player.playbackState
        if playerStatus == MPMusicPlaybackState.playing {
            player.pause()
        } else {
            player.play()
        }
    }
    @IBAction func leftSwiped() {
        player.skipToNextItem()
    }
    @IBAction func rightSwiped() {
        player.skipToPreviousItem()
    }

    deinit {
        // 再生中のアイテム変更に対する監視を外す
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
        //ミュージックプレイヤー通知の無効化
        player.endGeneratingPlaybackNotifications()
    }
}

