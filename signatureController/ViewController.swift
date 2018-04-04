//
//  ViewController.swift
//  signatureController
//
//  Created by BBI-M 1024-ADMIN on 23/03/18.
//  Copyright © 2018 BBI-M 1024-ADMIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var lastPoint = CGPoint.init(x: 0, y: 0)
//    var red: CGFloat = 0.0
//    var green: CGFloat = 0.0
//    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 2.0
    var opacity: CGFloat = 1.0
    var swiped = false
    @IBOutlet var tempImage: UIImageView!
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var drawingPad: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        lastPoint = CGPoint.init(x: 0, y: 0)
        if let touch = touches.first {
            lastPoint = touch.location(in:drawingPad)
        }
        
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(mainImage.image!, self, nil, nil)
    }
    @IBAction func clearButtonClicked(_ sender: Any) {
        mainImage.image = nil
    }
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(drawingPad.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImage.image?.draw(in: CGRect(x: 0, y: 0, width: drawingPad.frame.size.width, height: drawingPad.frame.size.height))
   
        context!.move(to:fromPoint)

        context!.addLine(to: toPoint)

        context!.setLineCap(CGLineCap.round)

        context!.setLineWidth(brushWidth)

        context?.setStrokeColor(UIColor.black.cgColor)

        context!.setBlendMode(CGBlendMode.normal)

        context!.strokePath()

        tempImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImage.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped=true
        if let touch=touches.first
        {
            let currentPoint=touch.location(in: drawingPad)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            lastPoint=currentPoint
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if !swiped {
//            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
//        }
        UIGraphicsBeginImageContext(mainImage.frame.size)
        mainImage.image?.draw(in: CGRect(x: 0, y: 0, width: drawingPad.frame.size.width, height: drawingPad.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        tempImage.image?.draw(in:  CGRect(x: 0, y: 0, width: drawingPad.frame.size.width, height: drawingPad.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        mainImage.image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImage.image=nil
        
    }

}

