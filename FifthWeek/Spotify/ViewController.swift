//
//  ViewController.swift
//  Spotify
//
//  Created by Nick Wang on 17/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    // 懒加载播放器
    lazy var player: AVPlayer? = {
        guard let path = Bundle.main.path(forResource: "login-bg-video.mp4", ofType: nil) else { return nil }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.videoGravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        playerController.showsPlaybackControls = false
        playerController.view.frame = view.bounds
        view.insertSubview(playerController.view, at: 0)
        addChildViewController(playerController)
        player?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(replay), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    @objc func replay() {
        // 重新从头开始播放
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

