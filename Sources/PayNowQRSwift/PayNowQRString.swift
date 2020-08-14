//
//  PayNowQRString.swift
//  
//
//  Created by Ansh on 14/8/20.
//

import Foundation


public func payNowQRString(_beneficiaryType : PayNowQRStringStruct.beneficiaryTypeEnum, _beneficiary : String, _beneficiaryName : String, amount : String, reference : String, amountIsEditable : Bool, _expiryDate : String?) -> String {
    
    let finalQRString = PayNowQRStringStruct(beneficiaryType_: _beneficiaryType, beneficiary_: _beneficiary, beneficiaryName_: _beneficiaryName, amount_: amount, reference_: reference, amountIsEditable_: amountIsEditable, expiryDate_: _expiryDate).finalPayNowQRString
    
    return finalQRString
    
}
