//
//  NKHeaderView.swift
//  Project04-CountryList
//
//  Created by Nick Wang on 20/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

protocol NKHeaderViewDelegate {
    func openOrCloseContent(index:Int)
}

class NKHeaderView: UIView {
    var delegate: NKHeaderViewDelegate?
    var index: Int?
    init(frame: CGRect,continet: ContinentModel,index: Int) {
        super.init(frame: frame)
        self.index = index
        let continetNameLabel = UILabel.init(frame: CGRect(x: 10, y: 5, width: 300, height: 40))
        continetNameLabel.text = continet.name
        addSubview(continetNameLabel)
        
        let openOrCloseBtn = UIButton.init(type: .custom)
        openOrCloseBtn.frame = CGRect(x: UIScreen.main.bounds.size.width - 30 , y: 15, width: 20, height: 20)
        openOrCloseBtn.addTarget(self, action: #selector(openOrClose(sender:)), for: .touchUpInside)
        openOrCloseBtn.setImage(UIImage.init(named: continet.isOpen ? "minus":"add"), for: .normal)
        addSubview(openOrCloseBtn)
        backgroundColor = UIColor.gray
    }
    @objc func openOrClose(sender:UIButton){
        guard (delegate != nil) else {
            return
        }
        delegate?.openOrCloseContent(index: self.index!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
