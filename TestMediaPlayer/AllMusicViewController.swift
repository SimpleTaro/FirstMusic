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
    
    /********************************************
     バグってます！！！！！！！！！！！！！！！！！！！！！
    ********************************************/
    
    @IBOutlet var allMusicTable: UITableView?
    
    var player : MPMusicPlayerController?
    //var songs : MPMediaItemCollection?
    var songQuery : MPMediaQuery?
    var imgArray = NSMutableArray()
    var songNameArray = NSMutableArray()
    var albumArtistArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Load")
        // Do any additional setup after loading the view.
        songQuery = updateSong()
        updateSongName()
        updateAlbumTitle()
        updateArtistImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Queryを取得する
    func updateSong() -> MPMediaQuery {
        NSLog("Query")
        let songQuery: MPMediaQuery = MPMediaQuery.songs()
        //songs = MPMediaItemCollection(items: songQuery.items!)
        return songQuery
    }
    
    //Queryからジャケットを取り出す
    func updateArtistImage(){
        NSLog("Image")
        //TODO 初期化必要じゃないか？？？
        for songsCollections in (songQuery?.collections)!{
            //imgArray.adding(songsCollections.representativeItem?.artwork)
            if let artwork = songsCollections.representativeItem?.artwork {
                let image = artwork.image
                imgArray.add(image)
            } else {
                // アートワークがない時
                // 今回は灰色にした
                imgArray.adding("default")
            }
        }
    }
    
    //Queryから曲名を取り出す
    func updateSongName(){
        NSLog("song")
        //TODO 初期化必要じゃないか？？？
        for songCollections in (songQuery?.collections)!{
            songNameArray.add(songCollections.representativeItem?.title ?? "不明な曲")
        }
    }
    
    //Queryからアーティストを取り出す
    func updateAlbumTitle(){
        NSLog("artist")
        //TODO 初期化必要じゃないか？？？
        for songsCollections in (songQuery?.collections)!{
            albumArtistArray.add(songsCollections.representativeItem?.albumArtist ?? "不明なアーティスト")
        }
        NSLog(String(albumArtistArray.count))
    }
    
    //tableview のセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("count")
        NSLog(String((songQuery?.collections!.count)!))
        return (songQuery?.collections!.count)!
    }
    
    //各セルの要素を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tablecellのIDでUITableViewCellのインスタンスを生成
        let cell = allMusicTable?.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        
        let img = UIImage(named:"¥(imgArray[indexPath.row])")
        
        //Tag番号1でUIImageView インスタンス作成
        let imageView = allMusicTable?.viewWithTag(1) as! UIImageView
        imageView.image = img
        
        //Tag番号2で UILabel インスタンス作成
        let label1 = allMusicTable?.viewWithTag(2) as! UILabel
        label1.text = "\(songNameArray[indexPath.row])"
        
        //Tag番号3で UILabel インスタンスの生成
        let label2 = allMusicTable?.viewWithTag(3) as! UILabel
        label2.text = "\(albumArtistArray[indexPath.row])"
        
        return cell!
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
