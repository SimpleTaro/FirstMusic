//
//  ShuffleMusicViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2017/01/02.
//  Copyright © 2017年 Takeru. All rights reserved.
//

import UIKit
import MediaPlayer

class ShuffleMusicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var shuffleMusicTable: UITableView?

    var musicPlayer = MusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musicPlayer.updateSufflePlaylist()
        musicPlayer.updatePlaylist()

        shuffleMusicTable?.delegate = self
        shuffleMusicTable?.dataSource = self
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
        NSLog(String(indexPath.row))
        //tablecellのIDでUITableViewCellのインスタンスを生成
        let cell = shuffleMusicTable?.dequeueReusableCell(withIdentifier: "shuffleMusicCell", for: indexPath)
        let item = musicPlayer.playlist[indexPath.row]
        
        let size = CGSize()
        let imageView = shuffleMusicTable?.viewWithTag(1) as! UIImageView
        if let artwork = item.artwork {
            imageView.image = artwork.image(at: size)
        }
        
        let label1 = shuffleMusicTable?.viewWithTag(2) as! UILabel
        label1.text = item.title
        
        let label2 = shuffleMusicTable?.viewWithTag(3) as! UILabel
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
    
    //編集ボタン押下時に呼ばれるメソッド
    @IBAction func changeMode(sender: AnyObject) {
        //通常モードと編集モードを切り替える。
        if(shuffleMusicTable?.isEditing == true) {
            shuffleMusicTable?.isEditing = false
            
            //キューに詰め込む
            musicPlayer.playlistToQueue(playlist: musicPlayer.playlist)
        } else {
            shuffleMusicTable?.isEditing = true
            musicPlayer.player.stop()
            musicPlayer.player.nowPlayingItem = MPMediaItem.init()

            musicPlayer.clearQueue3()
        }
    }
    
    //テーブルビュー編集時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //削除の場合、配列からデータを削除する。
        if( editingStyle == UITableViewCellEditingStyle.delete) {
            musicPlayer.playlist.remove(at: indexPath.row)
        }
        
        //テーブルの再読み込み
        tableView.reloadData()
    }
    
    //並び替え時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        
        //移動されたデータを取得する。
        let moveData = musicPlayer.playlist[sourceIndexPath.row]
        
        //元の位置のデータを配列から削除する。
        musicPlayer.playlist.remove(at: sourceIndexPath.row)
        
        //移動先の位置にデータを配列に挿入する。
        musicPlayer.playlist.insert(moveData, at:destinationIndexPath.row)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
