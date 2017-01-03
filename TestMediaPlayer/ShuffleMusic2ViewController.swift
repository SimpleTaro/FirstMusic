//
//  ShuffleMusic2ViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2017/01/03.
//  Copyright © 2017年 Takeru. All rights reserved.
//

import UIKit

class ShuffleMusic2ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var shuffleMusic2Table: UITableView?
    
    var musicPlayer = MusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musicPlayer.updateSufflePlaylist()
        shuffleMusic2Table?.delegate = self
        shuffleMusic2Table?.dataSource = self
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
        let cell = shuffleMusic2Table?.dequeueReusableCell(withIdentifier: "shuffleMusic2Cell", for: indexPath)
        let item = musicPlayer.playlist[indexPath.row]
        
        let size = CGSize()
        let imageView = shuffleMusic2Table?.viewWithTag(1) as! UIImageView
        if let artwork = item.artwork {
            imageView.image = artwork.image(at: size)
        }
        
        let label1 = shuffleMusic2Table?.viewWithTag(2) as! UILabel
        label1.text = item.title
        
        let label2 = shuffleMusic2Table?.viewWithTag(3) as! UILabel
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}