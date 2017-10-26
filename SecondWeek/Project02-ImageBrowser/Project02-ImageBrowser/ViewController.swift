//
//  ViewController.swift
//  Project02-ImageBrowser
//
//  Created by Nick Wang on 26/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit


struct model {
    var picName: String
    var picDescription: String
}
class ViewController: UIViewController {
   
    var arr = [model]()
    func prepareData() {
        let brokenHeart = model(picName: "BrokenHeart", picDescription: "My Broken Heart💔💔💔💔!!!")
        let iLoveYou = model(picName: "ILoveYou", picDescription: "I love you so much!!!")
        let linyuner = model(picName: "linyuner", picDescription: "Nice to meet you!")
        let seekingArrangment = model(picName: "SeekingArrangment", picDescription: "Seeking for somebody")
        let summer = model(picName: "summer", picDescription: "Summer is coming!")
        let wakeup = model(picName: "wakeup", picDescription: "Hi man! Wake up!")
        arr = [brokenHeart,iLoveYou,linyuner,seekingArrangment,summer,wakeup]
    }
    override func viewDidLoad() {
        prepareData()
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundPic")!)
        let tableView = UITableView.init(frame: CGRect(x:0,y:0,width:view.bounds.size.height - 200,height:view.bounds.size.width), style: .grouped)
        tableView.backgroundColor = UIColor.clear
        tableView.transform = CGAffineTransform(rotationAngle: .pi / 2) // 把tableView顺时针旋转90度
        tableView.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

    }

}
extension  ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.size.width * 4 / 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.transform = CGAffineTransform(rotationAngle: -.pi / 2) // 把cell逆时针旋转90度
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        
        
        let cellBackgroundView = UIView(frame: CGRect(x:0,y:0,width:view.bounds.size.width * 4 / 5,height:tableView.bounds.size.width - 50))
        cellBackgroundView.layer.cornerRadius = 20
        cellBackgroundView.layer.masksToBounds = true
        cellBackgroundView.backgroundColor = UIColor.clear
        cell.addSubview(cellBackgroundView)
        
        let imageView = UIImageView.init(frame: CGRect(x:0,y:0,width:view.bounds.size.width * 4 / 5,height:cellBackgroundView.bounds.size.height))
        imageView.image = UIImage(named: arr[indexPath.section].picName)
        imageView.contentMode = .scaleToFill
        cellBackgroundView.addSubview(imageView)
        
        // 添加毛玻璃效果和文字
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView.init(effect: blurEffect)
        effectView.frame = CGRect(x:0,y:cellBackgroundView.bounds.size.height - 80,width:view.bounds.size.width * 4 / 5,height: 80)
        let textLabel = UILabel(frame: CGRect(x:20,y:0,width:view.bounds.size.width * 4 / 5,height: 80))
        textLabel.font = UIFont(name: "Body", size: 18)
        textLabel.text = arr[indexPath.section].picDescription
        effectView.contentView.addSubview(textLabel)
        cellBackgroundView.addSubview(effectView)
    
        return cell
    }
}
