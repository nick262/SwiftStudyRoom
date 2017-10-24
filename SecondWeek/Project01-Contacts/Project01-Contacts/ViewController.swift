//
//  ViewController.swift
//  Project01-Contacts
//
//  Created by Nick Wang on 24/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let arr = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var recentArr: [ContactsModel]?
    var friendsArr: [ContactsModel]?
    let sectionTitle = ["Recent","Friends"]
    func getMobile(numbers:[String]) -> String {
        let str = numbers.sorted { (_, _) -> Bool in
            arc4random() < arc4random()
            }.joined()
        return str
    }
    func prepareData() {
        let KeithHansen = ContactsModel.init(avatar: "B001", name: "Keith Hansen", mobile:"1231231234" , email: "keithHansen@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        
        let TheresaSnyder = ContactsModel.init(avatar: "B002", name: "Theresa Snyder", mobile:getMobile(numbers: arr) , email: "theresa.snyder@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let JasonBerry = ContactsModel.init(avatar: "B003", name: "Jason Berry", mobile:getMobile(numbers: arr) , email: "jason.berry@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let LauraHarper = ContactsModel.init(avatar: "B004", name: "Laura Harper", mobile:getMobile(numbers: arr) , email: "laura.harper@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let JohnAppleseed = ContactsModel.init(avatar: "B005", name: "John Appleseed", mobile:getMobile(numbers: arr) , email: "john.appleseed@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        recentArr = [KeithHansen,TheresaSnyder,JasonBerry,LauraHarper,JohnAppleseed];
        let VictoriaGonzales = ContactsModel.init(avatar: "B006", name: "Victoria Gonzales", mobile:getMobile(numbers: arr) , email: "victoria.gonzales@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let JonathanHall = ContactsModel.init(avatar: "B007", name: "Jonathan Hall", mobile:getMobile(numbers: arr) , email: "jonathan.hall@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let SharonSanchez = ContactsModel.init(avatar: "B008", name: "Sharon Sanchez", mobile:getMobile(numbers: arr) , email: "Sharon.Sanchez@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let DanielMorgan = ContactsModel.init(avatar: "B009", name: "Daniel Morgan", mobile:getMobile(numbers: arr) , email: "Daniel.Morgan@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let KathleenGuerrero = ContactsModel.init(avatar: "B010", name: "Kathleen Guerrero", mobile:getMobile(numbers: arr) , email: "Kathleen.Guerrero@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let JoshuaWatkins = ContactsModel.init(avatar: "B011", name: "Joshua Watkins", mobile:getMobile(numbers: arr) , email: "Joshua.Watkins@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let AmandaCastillo = ContactsModel.init(avatar: "B012", name: "Amanda Castillo", mobile:getMobile(numbers: arr) , email: "Amanda.Castillo@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let GaryRiley = ContactsModel.init(avatar: "B013", name: "GaryRiley", mobile:getMobile(numbers: arr) , email: "Gary.Riley@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let MelissaLewis = ContactsModel.init(avatar: "B014", name: "Melissa Lewis", mobile:getMobile(numbers: arr) , email: "Melissa.Lewis@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        let RobertNewman = ContactsModel.init(avatar: "B015", name: "Robert Newman", mobile:getMobile(numbers: arr) , email: "Robert.Newman@gmail.com", notes: "Hipster-friendly social mediaholic. Thinker. Evil student. Amateur beer junkie. Food fanatic.")
        friendsArr = [VictoriaGonzales,JonathanHall,SharonSanchez,DanielMorgan,KathleenGuerrero,JoshuaWatkins,AmandaCastillo,GaryRiley,MelissaLewis,RobertNewman]

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()

        navigationController?.navigationBar.barTintColor = UIColor.init(red: 20/255, green: 141/255, blue: 248/255, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Contacts"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "setting"), style: .plain, target: nil, action: nil)
        
        let tableView = UITableView(frame: CGRect.init(origin:CGPoint.init(x: 0, y: 0), size: view.bounds.size), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let nib = UINib(nibName: "NKTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (recentArr?.count)!
        }else {
            return (friendsArr?.count)!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NKTableViewCell
        cell.avatar.layer.cornerRadius = 25
        cell.avatar.layer.masksToBounds = true
        if indexPath.section == 0 {
            cell.nameLabel.text = recentArr![indexPath.row].name
            cell.avatar.image = UIImage.init(named: recentArr![indexPath.row].avatar)
        } else {
            cell.avatar.image = UIImage.init(named: friendsArr![indexPath.row].avatar)
            cell.nameLabel.text = friendsArr![indexPath.row].name
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC: InfoViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        if indexPath.section == 0 {
            infoVC.contactModel = recentArr?[indexPath.row]
        } else {
            infoVC.contactModel = friendsArr?[indexPath.row]
        }
         navigationController?.pushViewController(infoVC, animated:true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

