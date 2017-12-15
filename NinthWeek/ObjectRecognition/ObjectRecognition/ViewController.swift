//
//  ViewController.swift
//  ObjectRecognition
//
//  Created by Nick Wang on 15/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    let objectRecognitionModel = Inceptionv3()
    
    let resultInfoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建视频捕捉会话
        captureSession = AVCaptureSession.init()
        captureSession.sessionPreset = .inputPriority
        guard  let captureDevice = configureDevice() else { return }
        guard let input = try? AVCaptureDeviceInput.init(device: captureDevice) else {
            fatalError("Can't init captureDeviceInput")
        }
        captureSession.addInput(input)
        
        let outPut = AVCaptureVideoDataOutput.init()
        let queue = DispatchQueue.init(label: "com.nick.videoCaptureQueue")
        outPut.setSampleBufferDelegate(self, queue: queue)
        outPut.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String: NSNumber(value: kCVPixelFormatType_32BGRA)]
        outPut.alwaysDiscardsLateVideoFrames = true
        guard captureSession.canAddOutput(outPut) else {
            fatalError()
        }
        captureSession.addOutput(outPut)
        startCapturingWithSession(captureSession: captureSession)
        
        setUpResultInfoView()
    }
    func setUpResultInfoView() {
        resultInfoLabel.frame = CGRect.init(x: 10, y: view.bounds.size.height - 80, width: view.bounds.size.width - 20, height: 80)
        resultInfoLabel.textAlignment = .center
        resultInfoLabel.font = UIFont.systemFont(ofSize: 20)
        resultInfoLabel.textColor = UIColor.white
        resultInfoLabel.backgroundColor = UIColor.gray
        resultInfoLabel.numberOfLines = 0
        
        view.addSubview(resultInfoLabel)
    }
    func configureDevice() -> AVCaptureDevice? {
        guard let device = AVCaptureDevice.default(for: .video) else {return nil} // 是否可以选择前后摄像头?
        
        var customFormats = [AVCaptureDevice.Format]()
        let customFPS = Float64(3)
        for format in device.formats {
            for range in format.videoSupportedFrameRateRanges where range.minFrameRate <= customFPS && customFPS <= range.maxFrameRate {
                customFormats.append(format)
            }
        }
        
        let customSize = CGSize.init(width: 227, height: 227)
        
        var sizeFormat: AVCaptureDevice.Format?
        for format in customFormats {
            let desc = format.formatDescription
            let dimesions = CMVideoFormatDescriptionGetDimensions(desc)
            if dimesions.width >= Int32(customSize.width) && dimesions.height >= Int32(customSize.height) {
                sizeFormat = format
            }
        }
        
        do {
            try device.lockForConfiguration()
        } catch  {
            fatalError(" error when request configration")
        }
        device.activeFormat = sizeFormat!
        device.activeVideoMaxFrameDuration = CMTimeMake(1, Int32(customFPS))
        device.activeVideoMinFrameDuration = CMTimeMake(1, Int32(customFPS))
        device.focusMode = .continuousAutoFocus
        device.unlockForConfiguration()
        
        return device
    }
    
    func startCapturingWithSession(captureSession cap: AVCaptureSession) {
        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer.init(session: cap)
            previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewLayer?.frame.origin = self.view.frame.origin
            previewLayer?.frame.size = self.view.frame.size
            self.view.layer.insertSublayer(previewLayer!, at: 1)
        }
        cap.startRunning()
    }
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        handleImageBufferWithCoreML(imageBuffer: sampleBuffer)
    }
    
    // MARK: CoreML识别图片的方法
    func handleImageBufferWithCoreML(imageBuffer: CMSampleBuffer) {
        
        guard let buffer = CMSampleBufferGetImageBuffer(imageBuffer) else {
             print("could not get a pixel buffer")
            return
        }
        let capturedImage: UIImage
        do {
            CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags.readOnly)
            defer {
                CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags.readOnly)
            }
            let address = CVPixelBufferGetBaseAddressOfPlane(buffer, 0)
            let bytes = CVPixelBufferGetBytesPerRow(buffer)
            let width = CVPixelBufferGetWidth(buffer)
            let height = CVPixelBufferGetHeight(buffer)
            let color = CGColorSpaceCreateDeviceRGB()
            let bits = 8
            let info = CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
            guard let context = CGContext(data: address, width: width, height: height, bitsPerComponent: bits, bytesPerRow: bytes, space: color, bitmapInfo: info) else {
                print("could not create an CGContext")
                return
            }
            guard let image = context.makeImage() else {
                print("could not create an CGImage")
                return
            }
            capturedImage = UIImage(cgImage: image, scale: 1.0, orientation: UIImageOrientation.up)
            
        }
        
        
        let size = CGSize(width: 299, height: 299)
        UIGraphicsBeginImageContext(size)
        capturedImage.draw(in: CGRect(origin: CGPoint(x:0,y:0), size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cvPixelBuffer = uiImageToCVPixelBuffer(from: scaledImage!)
        
        do {
            let prediction = try self.objectRecognitionModel.prediction(image: cvPixelBuffer!)
            DispatchQueue.main.async {
                var name: String = ""
                var confidence: Double = 0
                for index in prediction.classLabelProbs {
                    if confidence < index.value {
                        confidence = index.value
                        name = index.key
                    }
                }

                let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.resultInfoLabel.frame.width, height: 0))
                label.text = "\(name):\(confidence)"
                label.font = self.resultInfoLabel.font
                label.numberOfLines = 0
                label.sizeToFit()
                let height = label.frame.height * 2
                
                self.resultInfoLabel.text = "\(name):\(confidence)"
                self.resultInfoLabel.frame.size.height = height
                print(prediction.classLabel)
                print(prediction.classLabelProbs)
            }
        } catch let error as NSError {
            fatalError("Unexpected error ocurred: \(error.localizedDescription).")
        }
    }
    func uiImageToCVPixelBuffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}


