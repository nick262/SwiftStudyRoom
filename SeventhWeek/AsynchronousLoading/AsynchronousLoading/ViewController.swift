//
//  ViewController.swift
//  AsynchronousLoading
//
//  Created by Nick Wang on 28/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        basicOperation()
    }
    // 最基本的使用Operation
    fileprivate func basicOperation() {
        // 第一步:创建Operation
        let operation = Operation.init()
        // 第二步:把要执行的代码放到operation中
        operation.completionBlock = {
            print(#function,#line,Thread.current)
            self.creatBasicBlockOperation()

        }
        // 第三步:创建OperationQueue
        let operationQueue = OperationQueue.init()
        // 第四步:把operation加入到线程中
        operationQueue.addOperation(operation)
        
    }
    //创建一个简单的BlockOperation
    //创建完Operation如果直接运行，就会在当前线程执行。也就是说，如果实在主线程创建并且start的，那就会在主线程执行；如果是在子线程创建并且start的，那就会在子线程执行。
    private func creatBasicBlockOperation() {
        //使用BlockOperation创建operation
        let operation = BlockOperation.init {
            //打印，看看在哪个线程中

            print(#function,#line,Thread.current)
        }

        
        //直接运行operation，看看运行在哪个线程中
        operation.start()
    }

}

