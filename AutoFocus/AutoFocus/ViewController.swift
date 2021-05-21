//
//  ViewController.swift
//  AutoFocus
//
//  Created by Marius Grossu on 19.05.2021.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //variables
    
    private let captureSession = AVCaptureSession()
    //lazy because first the captureSession needs to be loaded
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer(session: self.captureSession)
        preview.videoGravity = .resizeAspectFill
        return preview
    }()
    private let device = AVCaptureDevice.default(for: .video)!
    private let videoOutput = AVCaptureVideoDataOutput()
    private var focusPoints: [CGPoint] = []

    //functions
    
    //add default rear camera feed
    private func addCameraInput(_ device: AVCaptureDevice){
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        self.captureSession.addInput(cameraInput)
    }
    
    //display the camera feed
    private func addPreviewLayer() {
        self.view.layer.addSublayer(self.previewLayer)
    }
    
    //send live camera frames to ViewController
    private func addVideoOutput() {
        self.videoOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        self.videoOutput.alwaysDiscardsLateVideoFrames = true
        self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
        self.captureSession.addOutput(self.videoOutput)
        
        guard let connection = self.videoOutput.connection(with: AVMediaType.video),
                connection.isVideoOrientationSupported else { return }
            connection.videoOrientation = .portrait
    }
    
    //focus on the face detected
    private func handleFaceDetectionResultsFocus(_ observedFaces: [VNFaceObservation]) {
        DispatchQueue.main.async {
                for face in observedFaces
                {
                    let box = face.boundingBox
                    let boxOnScreen = self.convert(rect: box)
                    let focusPoint: CGPoint = CGPoint(x: boxOnScreen.midX, y: boxOnScreen.midY)
                    self.changeFocus(focusPoint, self.device)
                }
        }
    }
        
    private func convert(rect: CGRect) -> CGRect{
        let boxOnScreen = self.previewLayer.layerRectConverted(fromMetadataOutputRect: rect)
        return boxOnScreen
    }
    
    private func changeFocus(_ focusPoint: CGPoint,_ device:AVCaptureDevice){
        do {
        try device.lockForConfiguration()
        if device.isFocusPointOfInterestSupported && device.isFocusModeSupported(.autoFocus){
            device.focusPointOfInterest = focusPoint
            print("Face on x: \(focusPoint.x) and y: \(focusPoint)")
            device.focusMode = .autoFocus
        }
        device.unlockForConfiguration()
        } catch {
            print("Could not lock device for configuration: \(error)")
        }
    }
    
    //make the request to detect the face, handles the request
    private func detectFace(in image: CVPixelBuffer) {
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                if let results = request.results as? [VNFaceObservation], results.count > 0 {
                    
                    print("did detect \(results.count) face(s)")
                    self.handleFaceDetectionResultsFocus(results)
                    
                } else {
                    print("did not detect any face")
                }
            }
        })
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, orientation: .leftMirrored, options: [:])
        try? imageRequestHandler.perform([faceDetectionRequest])
    }
    
    //receives the frames
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            debugPrint("unable to get image from sample buffer")
            return
        }
        //print("did receive image frame")
        // process image here
        self.detectFace(in: frame)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCameraInput(device)
        self.addPreviewLayer()
        self.addVideoOutput()
        self.captureSession.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewLayer.frame = self.view.bounds
    }


}
