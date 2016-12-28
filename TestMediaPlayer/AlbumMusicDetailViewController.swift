//
//  AlbumMusicDetailViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/25.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumMusicDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var allArtistMusicDetailTable: UITableView?
    var musicPlayer = MusicPlayer()
    
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var artistName: UILabel?
    @IBOutlet weak var albumName: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableview のセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("count")

        let size = CGSize()
        imageView?.image = musicPlayer.playlist[0].artwork?.image(at: size)
        artistName?.text = musicPlayer.playlist[0].artist
        albumName?.text = musicPlayer.playlist[0].albumTitle
        
        return musicPlayer.playlist.count
    }
    
    //各セルの要素を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("セルの設定")
        //tablecellのIDでUITableViewCellのインスタンスを生成
        let cell = allArtistMusicDetailTable?.dequeueReusableCell(withIdentifier: "AlbumMusicDetailCell", for: indexPath)
        let item = musicPlayer.playlist[indexPath.row]
        
        let label1 = allArtistMusicDetailTable?.viewWithTag(1) as! UILabel
        label1.text = item.title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //タッチされたセルの曲を再生
        musicPlayer.play(number: indexPath.row)
        
        // 選択を解除しておく
        tableView.deselectRow(at: indexPath, animated: true)
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
