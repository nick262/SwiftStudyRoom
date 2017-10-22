//
//  NKTableViewCell.swift
//  Project04-CountryList
//
//  Created by Nick Wang on 21/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

protocol NKTableViewCellDelegate {
    func openOrCloseContents(indexPath: NSIndexPath)
}

class NKTableViewCell: UITableViewCell {
    
    var delegate : NKTableViewCellDelegate?
    var indexPath : NSIndexPath?
    var cityView : UIView?
    var isOpen: Bool?
    init(style: UITableViewCellStyle, reuseIdentifier: String?, country: CountryModel, indexPath: NSIndexPath) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.indexPath = indexPath
        self.isOpen = country.isOpen
        let nameView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 20, height: 40))
        nameView.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 30))
        label.text = country.name
        nameView.addSubview(label)
        
        let openOrCloseBtn = UIButton(type: .custom)
        openOrCloseBtn.frame = CGRect(x: UIScreen.main.bounds.size.width - 60, y: 5, width: 20, height: 20)
        openOrCloseBtn.addTarget(self, action: #selector(openOrCloseContent(sender:)), for: .touchUpInside)
        openOrCloseBtn.setImage(UIImage(named: country.isOpen ? "arrow_down" :"arrow_right"), for: .normal)
        openOrCloseBtn.backgroundColor = UIColor.clear
        nameView.addSubview(openOrCloseBtn)
        contentView.addSubview(nameView)
        
        cityView = UIView(frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.size.width ), height: country.provinces.count * 40))
        cityView?.isHidden = !isOpen!

        for count in 0..<country.provinces.count {
            let provinceLabel = UILabel(frame: CGRect(x: 0, y: 40 * count, width: Int(UIScreen.main.bounds.size.width - 20), height: 40))
            provinceLabel.text = String("           \(country.provinces[count])")
            provinceLabel.layer.borderWidth = 0.5
            provinceLabel.layer.borderColor = UIColor.gray.cgColor
            cityView?.addSubview(provinceLabel)
        }
        
        contentView.addSubview(cityView!)
    }
    @objc func openOrCloseContent(sender:UIButton){
        if (delegate != nil) {
            delegate?.openOrCloseContents(indexPath: self.indexPath!)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
