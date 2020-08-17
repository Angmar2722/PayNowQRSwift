//
//  File.swift
//  
//
//  Created by Ansh on 16/8/20.
//

import UIKit


public func payNowQRImage(_beneficiaryType : beneficiaryTypeEnum, _beneficiary : String, _beneficiaryName : String, amount : CGFloat, reference : String, amountIsEditable : Bool, _expiryDate : Date?, qrWidthAndHeight : CGFloat, bottomLabelText : String?) -> UIImage {
        
    
    //Input Amount Parameters
    if amount > 10000000000 {
        fatalError("The amount entered cannot be greater than 13 characters.")
    } else if amount < 0 {
        fatalError("The amount entered cannot be a negative value.")
    }
    
    let convertedTo2DecimalPlaceAmountString = String(format: "%.2f", arguments: [amount])
    
    
    //Date Formatting
    let requiredDateFormat = DateFormatter()
    requiredDateFormat.dateFormat = "yyyyMMdd"
    
    var formattedDateString : String?
    
    if _expiryDate != nil {
        formattedDateString = requiredDateFormat.string(from: _expiryDate!)
    } else {
        formattedDateString = nil
    }
    
    
    //Input QR Code Width And Height Parameters
    if qrWidthAndHeight < 0 {
        fatalError("The QR Code width/height entered cannot be a negative value.")
    }
    
    
    let finalQRString = PayNowQRStringStruct(beneficiaryType_: _beneficiaryType, beneficiary_: _beneficiary, beneficiaryName_: _beneficiaryName, amount_: convertedTo2DecimalPlaceAmountString, reference_: reference, amountIsEditable_: amountIsEditable, expiryDate_: formattedDateString).finalPayNowQRString
    
    let payNowQRImageStructObject = PayNowQRImageStruct()
    
    //3 Images To Merge
    let qrImage = payNowQRImageStructObject.generateQRCode(from: finalQRString, with: qrWidthAndHeight)!
    let extraInfoLabelImage_ = payNowQRImageStructObject.getExtraInfoLabelImage(labelText: bottomLabelText, qrCodeWidthAndHeight: qrWidthAndHeight)
    let payNowLogoImage_ = #imageLiteral(resourceName: "Pay Now Logo")
    
    //Final Merged Image
    let finalQRImage = payNowQRImageStructObject.getFinalMergedImage(qrCodeWidthAndHeight: qrWidthAndHeight, qrCodeImage: qrImage, payNowLogoImage: payNowLogoImage_, extraInfoLabelImage: extraInfoLabelImage_)
        
    return finalQRImage
    
}
