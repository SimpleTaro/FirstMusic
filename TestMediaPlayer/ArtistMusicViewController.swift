//
//  ArtistMusicViewController.swift
//  TestMediaPlayer
//
//  Created by Takeru on 2016/12/28.
//  Copyright © 2016年 Takeru. All rights reserved.
//

import UIKit

class ArtistMusicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var artistMusicTable: UITableView?
    
    var musicPlayer = MusicPlayer()
    var albumArtistArray: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        musicPlayer.updateArtistlist()
        artistMusicTable?.delegate = self
        artistMusicTable?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //tableview のセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        // アーティストの数を数える
        for i in 0..<musicPlayer.artistPlaylist.count {
            if i != 0 {
                let beforeArtist: Int = i - 1
                var eachArtistCount: Int = 0
                // 被っていないアーティストだけalbumArtistArrayに追加する
                for j in 0..<beforeArtist + 1 {
                    
                    if musicPlayer.artistPlaylist[i].representativeItem?.albumArtist == musicPlayer.artistPlaylist[j].representativeItem?.albumArtist {
                    
                        eachArtistCount = eachArtistCount + 1
                    }
                }
                if eachArtistCount == 0 {
                    albumArtistArray.add(musicPlayer.artistPlaylist[i].representativeItem?.albumArtist! ?? "unknown")
                    count = count + 1
                }
            } else {
                
                albumArtistArray.add(musicPlayer.artistPlaylist[i].representativeItem?.albumArtist! ?? "unknown")
                count = count + 1
                
            }
        }
        return count
    }
    //各セルの要素を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("セルの設定")
        //tablecellのIDでUITableViewCellのインスタンスを生成
        let cell = artistMusicTable?.dequeueReusableCell(withIdentifier: "artistMusicCell", for: indexPath)
        let collection = albumArtistArray[indexPath.row]

        let label1 = artistMusicTable?.viewWithTag(1) as? UILabel
        label1?.text = String(describing: collection)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let artistName = String(describing: albumArtistArray[indexPath.row])
        musicPlayer.updateArtistAlbumMusiclist(artistName: artistName)
        musicPlayer.playlistToQueue(playlist: musicPlayer.playlist)
        
        // 選択を解除しておく
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let artistAlbumViewController: ArtistAlbumViewController = segue.destination as? ArtistAlbumViewController {
            artistAlbumViewController.musicPlayer = musicPlayer
        }
    }
}
