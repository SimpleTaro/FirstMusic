//
//  AllMusicViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/11.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import UIKit
import MediaPlayer

class AllMusicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var allMusicTable: UITableView?
    
    var musicPlayer = MusicPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Load")
        musicPlayer.updatePlaylistCollection()
        musicPlayer.updatePlaylist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableview のセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("count")
        return musicPlayer.playlist.count
    }
    //各セルの要素を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("セルの設定")
        //tablecellのIDでUITableViewCellのインスタンスを生成
        let cell = allMusicTable?.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        let item = musicPlayer.playlist[indexPath.row]
        
        let size = CGSize()
        let imageView = allMusicTable?.viewWithTag(1) as! UIImageView
        if let artwork = item.artwork {
            imageView.image = artwork.image(at: size)
        }
        
        let label1 = allMusicTable?.viewWithTag(2) as! UILabel
        label1.text = item.title
        
        let label2 = allMusicTable?.viewWithTag(3) as! UILabel
        let albumTitle: String = item.albumTitle!
        let artist: String = item.artist!
        label2.text = artist + "-" + albumTitle

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        musicPlayer.playlistToQueue(playlist: musicPlayer.playlist)
        
        //タッチされたセルの曲を再生
        musicPlayer.play(number: indexPath.row)
        
        // 選択を解除しておく
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
