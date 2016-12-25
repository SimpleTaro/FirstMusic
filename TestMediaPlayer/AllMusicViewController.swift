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
        // Do any additional setup after loading the view.
        musicPlayer.updatePlaylist()
        allMusicTable?.delegate = self
        allMusicTable?.dataSource = self
       // allMusicTable?.register(UITableViewCell.self(_:NSObject), forCellReuseIdentifier: "musicCell")
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
        
        //タッチされたセルの曲を再生
        musicPlayer.play(number: indexPath.row)
        
        // 選択を解除しておく
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        let viewController:ViewController = segue.destination as! ViewController
//        
//        if let mediaItem = player.nowPlayingItem {
//            viewController.artistLabel.text = mediaItem.artist ?? "不明なアーティスト"
//            viewController.albumLabel.text = mediaItem.albumTitle ?? "不明なアルバム"
//            viewController.songLabel.text = mediaItem.title ?? "不明な曲"
//        
//            // アートワークの表示
//            if let artwork = mediaItem.artwork {
//                let image = artwork.image(at: viewController.imageView.bounds.size)
//                viewController.imageView.image = image
//            } else {
//                // アートワークがない時
//                // 今回は灰色にした
//                viewController.imageView.image = nil
//                viewController.imageView.backgroundColor = UIColor.gray
//            }
//        }
//    }
    

}
