//
//  PayNowQRImage.swift
//  
//
//  Created by Ansh on 16/8/20.
//

import UIKit


struct PayNowQRImageStruct {
    
    //Constants
    let iPhone11QRCodeWidthAndHeight = CGFloat(283.9)
    
    //Function Which Generates The QR Code
    func generateQRCode(from string: String, with qrCodeWidthAndHeight: CGFloat) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            
            guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
            
            filter.setValue(data, forKey: "inputMessage")
            
            filter.setValue("H", forKey: "inputCorrectionLevel")
            colorFilter.setValue(filter.outputImage, forKey: "inputImage")
            colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1") // Background white
            colorFilter.setValue(CIColor(red: 124.0/256, green: 26.0/256, blue: 120.0/256, alpha: 1), forKey: "inputColor0") // Foreground (QR Code) Pay Now Purple Color

    
            guard let qrImage = colorFilter.outputImage else {return nil}
            let scaleX = qrCodeWidthAndHeight / qrImage.extent.size.width
            let scaleY = qrCodeWidthAndHeight / qrImage.extent.size.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            
            if let output = colorFilter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
            
        }
        
        return nil
        
    }
    
    
    //This Function Returns An Image Which Displays Information Below The QR Code
    func getExtraInfoLabelImage(labelText : String?, qrCodeWidthAndHeight : CGFloat) -> UIImage? {
        
        let extraInfoLabel = UILabel()
        
        if labelText == nil {
            
            return nil
            
        } else {
            
            extraInfoLabel.text = labelText
            
            extraInfoLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: CGFloat( (22 / iPhone11QRCodeWidthAndHeight) * qrCodeWidthAndHeight ))
            extraInfoLabel.textColor = UIColor.white
            extraInfoLabel.textAlignment = .center
            extraInfoLabel.adjustsFontSizeToFitWidth = true
            
            extraInfoLabel.frame = CGRect(x: 0, y: 0, width: qrCodeWidthAndHeight, height: CGFloat( (30 / iPhone11QRCodeWidthAndHeight) * qrCodeWidthAndHeight ))
            
            let payNowLogoPurpleColor = CIColor(red: 124.0/256, green: 26.0/256, blue: 120.0/256, alpha: 1)
            extraInfoLabel.backgroundColor = UIColor(ciColor: payNowLogoPurpleColor)
            
            
            UIGraphicsBeginImageContextWithOptions(extraInfoLabel.bounds.size, false, 0)
            extraInfoLabel.drawHierarchy(in: extraInfoLabel.bounds, afterScreenUpdates: true)
            let labelImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return labelImage!
            
        }
                
    }
    
    
    //This Function Returns The Final QR Code Image (Containing The QR Code, Logo And Extra Information)
    func getFinalMergedImage(qrCodeWidthAndHeight : CGFloat, qrCodeImage : UIImage, payNowLogoImage : UIImage, extraInfoLabelImage : UIImage?) -> UIImage {
        
        var bottomImageSize : CGSize
        
        //The Base Image Size If Extra Label Is Needed Or If It Isn't
        if extraInfoLabelImage != nil {
            bottomImageSize = CGSize(width: qrCodeWidthAndHeight, height: qrCodeWidthAndHeight + CGFloat( (40 / iPhone11QRCodeWidthAndHeight) * qrCodeWidthAndHeight ))
        } else {
            bottomImageSize = CGSize(width: qrCodeWidthAndHeight, height: qrCodeWidthAndHeight)
        }
        
        UIGraphicsBeginImageContext(bottomImageSize)
        
        
        //Draws The QR Code In A CG Rect
        qrCodeImage.draw(in: CGRect(x: 0, y: 0, width: qrCodeWidthAndHeight, height: qrCodeWidthAndHeight))
        
        
        //Calculates The Dimensions Of The Pay Now Logo
        let percentageAreaOfQRCodeOccupiedByLogo = CGFloat(15)
        let ratioOfLogoLengthToWidth = CGFloat(1.5)
        let areaOccupiedByPayNowLogo = (percentageAreaOfQRCodeOccupiedByLogo / CGFloat(100)) * (qrCodeWidthAndHeight * qrCodeWidthAndHeight)
        let widthOfLogo = (areaOccupiedByPayNowLogo / ratioOfLogoLengthToWidth).squareRoot()
        let lengthOfLogo = ratioOfLogoLengthToWidth * widthOfLogo
        
        //Draws The Pay Now Logo In A CG Rect
        let xCord = (qrCodeWidthAndHeight / 2) - (lengthOfLogo / 2)
        let yCord = (qrCodeWidthAndHeight / 2) - (widthOfLogo / 2)
        
        payNowLogoImage.draw(in: CGRect(x: xCord, y: yCord, width: lengthOfLogo, height: widthOfLogo) )
        
        
        //Adds The Label To The Bottom Of The QR Code
        if extraInfoLabelImage != nil {
            extraInfoLabelImage!.draw(in: CGRect(x: 0, y: qrCodeWidthAndHeight + CGFloat( (5 / iPhone11QRCodeWidthAndHeight) * qrCodeWidthAndHeight), width: qrCodeWidthAndHeight, height: CGFloat( (30 / iPhone11QRCodeWidthAndHeight) * qrCodeWidthAndHeight)))
        }
        
        
        //Stores The Newly Merged Image In A Constant
        let finalMergedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        
        UIGraphicsEndImageContext()
        
        return finalMergedImage
        
    }
    
    
}
