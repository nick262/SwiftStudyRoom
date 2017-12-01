//
//  ImageLoadOperation.swift
//  AsynchronousLoading
//
//  Created by Nick Wang on 30/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ImageLoadOperation: Operation {
    let item: Item
    var dataTask: URLSessionDataTask?
    let complete: (UIImage?) -> Void
    // 重载init方法,添加excute闭包参数
    init(forItem: Item,excute: @escaping (UIImage?) -> Void) {
        item = forItem
        complete = excute
        super.init()
    }
    //isExecuting: 是否执行中，需要实现KVO通知机制。
    fileprivate var _executing : Bool = false
    override var isExecuting: Bool {
        get {return _executing}
        set {
            if newValue != _executing {
                willChangeValue(forKey: "isExecuting")
                _executing = newValue
                didChangeValue(forKey: "isExecuting")
            }
        }
    }
    // isFinished: 是否已完成，需要实现KVO通知机制。
    fileprivate var _finished: Bool = false
    override var isFinished: Bool {
        get {return _finished}
        set {
            if newValue != _finished {
                willChangeValue(forKey: "isFinished")
                _finished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }
    //isAsynchronous: 该方法默认返回 false ，表示非并发执行。并发执行需要自定义并且返回 真。后面会根据这个返回值来决定是否并发。
    override var isAsynchronous: Bool {
        get {return true}
    }
    // 重载start方法,所有并行的 Operations 都必须重写这个方法，然后在想要执行的线程中手动调用这个方法。注意：任何时候都不能调用父类的start方法
    override func start() {
        if !isCancelled {
            isExecuting = true
            isFinished = false
            startOperation()
        } else {
            isFinished = true
        }
        if let url = item.imageUrl() {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {[weak self](data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    self?.endOperationWith(image: image)
                } else {
                    self?.endOperationWith(image: nil)
                }
            })
            dataTask.resume()
        } else  {
            self.endOperationWith(image: nil)
        }
    }
    override func cancel() {
        if !isCancelled {
            cancelOperation()
        }
        super.cancel()
        completeOperation()
    }
    // MARK:对外方法
    func startOperation() {
        completeOperation()
    }
    func cancelOperation() {
        dataTask?.cancel()
    }
    func completeOperation() {
        if isExecuting && !isFinished {
            isExecuting = false
            isFinished = true
        }
    }
    func endOperationWith(image: UIImage?) {
        if !isCancelled {
            complete(image)
            completeOperation()
        }
    }
}
