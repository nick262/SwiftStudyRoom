//
//  NKSegmentedView.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 02/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
protocol NKSegmentedViewDelegate {
    func segmentedView(_ sementedView: NKSegmentedView, selectedIndex index: Int)
}
class NKSegmentedView: UIView {
    var delegate: NKSegmentedViewDelegate?
    // 标题数组
    var titles: [String]!
    var currentIndex = 0
    // 是否是滚动的Title
    var isScrollEnable : Bool = false
    // 普通Title颜色
    var normalColor : UIColor = UIColor.white
    // 选中Title颜色
    var selectedColor : UIColor = UIColor.white

    // Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    // 滚动Title的字体间距
    var titleMargin : CGFloat = 20
    // title的高度
    var titleHeight : CGFloat = 44
    
    // 是否显示底部滚动条
    var isShowBottomLine : Bool = true
    // 底部滚动条的颜色
    var bottomLineColor : UIColor = UIColor.white
    // 底部滚动条的高度
    var bottomLineH : CGFloat = 2
    
    // 是否进行缩放
    var isNeedScale : Bool = true
    var scaleRange : CGFloat = 1.2
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height )
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.scrollsToTop = false
        return scrollV
    }()
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = bottomLineColor
        return bottomLine
    }()
    
    init(frame: CGRect,titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK:设置UI界面内容
extension NKSegmentedView {
    func setupUI() {
        // 1.添加Scrollview
        addSubview(scrollView)
        
        
        // 2.设置所有的标题Label
        setupTitleLabels()
        
        // 3.设置Label的位置
        setupTitleLabelsPosition()
        
        // 4.设置底部的滚动条
        if isShowBottomLine {
            setupBottomLine()
        }
    }
    func setupTitleLabels() {
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.tag = index
            label.text = title
            label.textColor = index == 0 ? selectedColor : normalColor
            label.font = font
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_ :)))
            label.addGestureRecognizer(tapGes)
            titleLabels.append(label)
            scrollView.addSubview(label)
            
        }
    }
    func setupTitleLabelsPosition(){
        var titleX: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleY: CGFloat = 10.0
        let titleH : CGFloat = frame.height
        
        let count = titles.count
        
        for (index, label) in titleLabels.enumerated() {
            if isScrollEnable {
                let rect = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : font], context: nil)
                titleW = rect.width
                if index == 0 {
                    titleX = titleMargin * 0.5
                } else {
                    let preLabel = titleLabels[index - 1]
                    titleX = preLabel.frame.maxX + titleMargin
                }
                
            } else {
                titleW = frame.width / CGFloat(count)
                titleX = titleW * CGFloat(index)
            }
            
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            
            // 放大的代码
            if index == 0 {
                let scale = isNeedScale ? scaleRange : 1.0
                label.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        if isScrollEnable {
            scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + titleMargin * 0.5, height: 0)
        }
    }
    func setupBottomLine(){
        scrollView.addSubview(bottomLine)
        bottomLine.frame = titleLabels.first!.frame
        bottomLine.frame.size.height = bottomLineH
        bottomLine.frame.origin.y = bounds.height - bottomLineH - 5
    }
}
// MARK:- 事件处理
extension NKSegmentedView {
    @objc fileprivate func titleLabelClick(_ tap : UITapGestureRecognizer) {
        // 0.获取当前Label
        guard let currentLabel = tap.view as? UILabel else { return }
        
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = selectedColor
        oldLabel.textColor = normalColor
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.通知代理
        delegate?.segmentedView(self, selectedIndex: currentIndex)
        
        // 6.居中显示
        contentViewDidEndScroll()
        
        // 7.调整bottomLine
        if isShowBottomLine {
            UIView.animate(withDuration: 0.15, animations: {
                self.bottomLine.frame.origin.x = currentLabel.frame.origin.x
                self.bottomLine.frame.size.width = currentLabel.frame.size.width
            })
        }
        
        // 8.调整比例
        if isNeedScale {
            oldLabel.transform = CGAffineTransform.identity
            currentLabel.transform = CGAffineTransform(scaleX: scaleRange, y: scaleRange)
        }
        
    }
    
    func contentViewDidEndScroll() {
        // 0.如果是不需要滚动,则不需要调整中间位置
        guard isScrollEnable else { return }
        
        // 1.获取获取目标的Label
        let targetLabel = titleLabels[currentIndex]
        
        // 2.计算和中间位置的偏移量
        var offSetX = targetLabel.center.x - bounds.width * 0.5
        if offSetX < 0 {
            offSetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offSetX > maxOffset {
            offSetX = maxOffset
        }
        
        // 3.滚动UIScrollView
        scrollView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}

