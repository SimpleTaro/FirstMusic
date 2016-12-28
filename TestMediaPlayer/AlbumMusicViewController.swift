//
//  AlbumMusicViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/25.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import UIKit

class AlbumMusicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var allArtistMusicTable: UITableView?
    
    var musicPlayer = MusicPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musicPlayer.updateAlbumlist()
        allArtistMusicTable?.delegate = self
        allArtistMusicTable?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableview のセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("count")
        return musicPlayer.albumPlaylist.count
    }
    //各セルの要素を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("セルの設定")
        //tablecellのIDでUITableViewCellのインスタンスを生成
        let cell = allArtistMusicTable?.dequeueReusableCell(withIdentifier: "artistMusicCell", for: indexPath)
        let item = musicPlayer.albumPlaylist[indexPath.row]
        
        let size = CGSize()
        let imageView = allArtistMusicTable?.viewWithTag(1) as! UIImageView
        if let artwork = item.representativeItem?.artwork {
            imageView.image = artwork.image(at: size)
        }
        
        let label1 = allArtistMusicTable?.viewWithTag(2) as! UILabel
        label1.text = item.representativeItem?.albumTitle
        
        let label2 = allArtistMusicTable?.viewWithTag(3) as! UILabel
        label2.text = item.representativeItem?.artist
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        musicPlayer.updateAlbumPlaylist(number: indexPath.row)

        // 選択を解除しておく
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let albumMusicDetailViewController: AlbumMusicDetailViewController = segue.destination as? AlbumMusicDetailViewController {
        albumMusicDetailViewController.musicPlayer = musicPlayer
        }
    }
}
