//
//  PayNowQRString.swift
//  
//
//  Created by Ansh on 14/8/20.
//

import UIKit


public func payNowQRString(_beneficiaryType : beneficiaryTypeEnum, _beneficiary : String, _beneficiaryName : String, amount : CGFloat, reference : String, amountIsEditable : Bool, _expiryDate : Date?) -> String {
    
    
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
    
    
    let finalQRString = PayNowQRStringStruct(beneficiaryType_: _beneficiaryType, beneficiary_: _beneficiary, beneficiaryName_: _beneficiaryName, amount_: convertedTo2DecimalPlaceAmountString, reference_: reference, amountIsEditable_: amountIsEditable, expiryDate_: formattedDateString).finalPayNowQRString
    
    
    return finalQRString
    
}
