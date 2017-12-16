//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Nick Wang on 16/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emotionsLabel: UILabel!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(named: "oldman") else {
            fatalError("no starting image")
        }
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        detectScene(image: ciImage)
    }


}

// MARK: - IBActions
extension ViewController {
    
    @IBAction func pickImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
}
// MARK: - Methods
extension ViewController {
    
    func detectScene(image: CIImage) {
        genderLabel.text = "detecting scene..."
        ageLabel.text = "......"
        emotionsLabel.text = "......"
        
        // 从生成的类中加载 ML 模型
        guard let genderModel = try? VNCoreMLModel(for: GenderNet().model),let ageModel = try? VNCoreMLModel(for: AgeNet().model),let emotionModel = try? VNCoreMLModel(for: CNNEmotions().model) else {
            fatalError("can't load ML model")
        }
        
        // 创建一个带有 completion handler 的 Vision 请求
        let request = VNCoreMLRequest(model: genderModel) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            // 在主线程上更新 UI
            DispatchQueue.main.async { [weak self] in
                self?.genderLabel.text = "Gender: \(topResult.identifier) \(Int(topResult.confidence * 100))% "
            }
        }
    
        let ageRequest = VNCoreMLRequest(model: ageModel) { [weak self] ageRequest, error in
            guard let ageResults = ageRequest.results as? [VNClassificationObservation],
                let topAgeResult = ageResults.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            // 在主线程上更新 UI
            DispatchQueue.main.async { [weak self] in
                self?.ageLabel.text = "Age: \(topAgeResult.identifier) \(Int(topAgeResult.confidence * 100))% "
            }
        }
        let emotionRequest = VNCoreMLRequest(model: emotionModel) { [weak self] emotionRequest, error in
            guard let emotionResults = emotionRequest.results as? [VNClassificationObservation],
                let topEmotionResult = emotionResults.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            // 在主线程上更新 UI
            DispatchQueue.main.async { [weak self] in
                self?.emotionsLabel.text = "Emotions: \(topEmotionResult.identifier) \(Int(topEmotionResult.confidence * 100))% "
            }
        }
        
        // 在主线程上运行 Core ML GoogLeNetPlaces 分类器
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
        
        let ageHandler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try ageHandler.perform([ageRequest])
            } catch {
                print(error)
            }
        }
        
        let emotionHandler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try emotionHandler.perform([emotionRequest])
            } catch {
                print(error)
            }
        }
        
       
        

    }
    
}



// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("couldn't load image from Photos")
        }
        
        imageView.image = image
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        
        detectScene(image: ciImage)
    }
}
// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
