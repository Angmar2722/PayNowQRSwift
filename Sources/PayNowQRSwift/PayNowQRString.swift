

public struct PayNowQRString {
    
    let beneficiaryType : beneficiaryTypeEnum
    let beneficiary : String
    let beneficiaryName : String
    let transactionAmount : String
    let referenceNumber : String
    let isEditable : Bool
    let expiryDate : String?
    
    
    //Initializing Enumerations
    enum beneficiaryTypeEnum {
        case Mobile
        case UEN
    }
    
    
    public init(_beneficiaryType : beneficiaryTypeEnum, _beneficiary : String, _beneficiaryName : String, amount : String, reference : String, amountIsEditable : Bool, _expiryDate : String?) {
        
        beneficiaryType = _beneficiaryType
        beneficiary = _beneficiary
        beneficiaryName = _beneficiaryName
        transactionAmount = amount
        referenceNumber = reference
        isEditable = amountIsEditable
        //If The Input Expiry Date Is "0", The Expiry Date Is Not Generated
        expiryDate = _expiryDate
        
    }
    
    
    //Payload Format Indicator String
    let payloadFormatIndicatorStringID = "00"
    let payloadFormatIndicatorStringValue = "01"
    var payloadFormatIndicatorStringCharLength : String {
        return "0\(payloadFormatIndicatorStringValue.count)"
    }
    var payloadFormatIndicatorString : String {
        return "\(payloadFormatIndicatorStringID)\(payloadFormatIndicatorStringCharLength)\(payloadFormatIndicatorStringValue)"
    }
        
        
    //Point Of Initiation Method
    let pointOfInitiationMethodStringID = "01"
    //For The Value, 11 = Static, 12 = Dynamic
    let pointOfInitiationMethodStringValue = "12"
    var pointOfInitiationMethodStringCharLength : String {
        return "0\(pointOfInitiationMethodStringValue.count)"
    }
    var pointOfInitiationMethodString : String {
        return "\(pointOfInitiationMethodStringID)\(pointOfInitiationMethodStringCharLength)\(pointOfInitiationMethodStringValue)"
    }
        
        
    //Merchant Account Info Template Sub-Category : Electronic Fund Transfer Service
    let electronicFundTransferServiceStringID = "00"
    let electronicFundTransferServiceStringValue = "SG.PAYNOW"
    var electronicFundTransferServiceStringCharLength : String {
        return "0\(electronicFundTransferServiceStringValue.count)"
    }
    var electronicFundTransferServiceString : String {
        return "\(electronicFundTransferServiceStringID)\(electronicFundTransferServiceStringCharLength)\(electronicFundTransferServiceStringValue)"
    }
    
        
    //Merchant Account Info Template Sub-Category : Beneficiary Type Selected
    let beneficiaryTypeSelectedStringID = "01"
    //The Value 0 = Mobile, 1 = Unused, 2 = UEN
    var beneficiaryTypeStringValue : String {
        switch beneficiaryType {
        case .Mobile:
            return "0"
        case .UEN:
            return "2"
        }
    }
    var  beneficiaryTypeStringCharLength : String {
        return "0\(beneficiaryTypeStringValue.count)"
    }
    var beneficiaryTypeString : String {
        return "\(beneficiaryTypeSelectedStringID)\(beneficiaryTypeStringCharLength)\(beneficiaryTypeStringValue)"
    }
    
        
    //Merchant Account Info Template Sub-Category : UEN Value (Company Unique Entity Number)
    let beneficiaryValueStringID = "02"
    var beneficiaryValueStringValue : String {
        return beneficiary
    }
    var beneficiaryValueStringCharLength : String {
        
        if beneficiaryValueStringValue.count >= 10 {
            return "\(beneficiaryValueStringValue.count)"
        } else if beneficiaryValueStringValue.count < 10 {
            return "0\(beneficiaryValueStringValue.count)"
        } else {
            return String("Failed To Return Beneficiary Value Character Length")
        }
        
    }
    var beneficiaryValueString : String {
        return "\(beneficiaryValueStringID)\(beneficiaryValueStringCharLength)\(beneficiaryValueStringValue)"
    }
    
        
    //Merchant Account Info Template Sub-Category : Payment Is Or Is Not Editable
    let isPaymentEditableStringID = "03"
    //The Value 0 = Payment Not Editable, 1 = Payment Is Editable
    var isPaymentEditableStringValue : String {
        if isEditable == true {
            return "1"
        } else {
            return "0"
        }
    }
    var isPaymentEditableStringCharLength : String {
        return "0\(isPaymentEditableStringValue.count)"
    }
    var isPaymentEditableString : String {
        return "\(isPaymentEditableStringID)\(isPaymentEditableStringCharLength)\(isPaymentEditableStringValue)"
    }
    
        
    //Merchant Account Info Template Sub-Category : Expiry Date (YYYYMMDD Format) (This Is An Optional Category)
    var expiryDateString : String {
        
        if expiryDate == "nil" {
            return ""
        } else {
            let expiryDateStringID = "04"
            let expiryDateStringValue = expiryDate!
            let expiryDateStringCharLength = "0\(expiryDateStringValue.count)"
            return "\(expiryDateStringID)\(expiryDateStringCharLength)\(expiryDateStringValue)"
        }
        
    }
  
        
    //Merchant Account Info Template (ID-26)
    let merchantAccountInfoTemplateStringID = "26"
    var merchantAccountInfoTemplateStringCharLength : String {
        return String(electronicFundTransferServiceString.count + beneficiaryTypeString.count + beneficiaryValueString.count + isPaymentEditableString.count + expiryDateString.count)
    }
    var merchantAccountInfoTemplateString : String {
        return "\(merchantAccountInfoTemplateStringID)\(merchantAccountInfoTemplateStringCharLength)\(electronicFundTransferServiceString)\(beneficiaryTypeString)\(beneficiaryValueString)\(isPaymentEditableString)\(expiryDateString)"
    }
        
        
    //Merchant Category Code
    let merchantCategoryCodeStringID = "52"
    //The Value For The Merchant Category Code = 0000 If It Is Unused
    let merchantCategoryCodeStringValue = "0000"
    var merchantCategoryCodeStringCharLength : String {
        return "0\(merchantCategoryCodeStringValue.count)"
    }
    var merchantCategoryCodeString : String {
        return "\(merchantCategoryCodeStringID)\(merchantCategoryCodeStringCharLength)\(merchantCategoryCodeStringValue)"
    }
        
        
    //Currency Code
    let currencyCodeStringID = "53"
    //The Currency Code Of Singapore Is 702
    let currencyCodeStringValue = "702"
    var currencyCodeStringCharLength : String {
        return "0\(currencyCodeStringValue.count)"
    }
    var currencyCodeString : String {
        return "\(currencyCodeStringID)\(currencyCodeStringCharLength)\(currencyCodeStringValue)"
    }
        
        
    //The Transaction Amount In Dollars
    let transactionAmountStringID = "54"
    var transactionAmountStringValue : String {
        return transactionAmount
    }
    var transactionAmountStringCharLength : String {
        
        if transactionAmountStringValue.count >= 10 {
            return  "\(transactionAmountStringValue.count)"
        } else if transactionAmountStringValue.count < 10 {
            return "0\(transactionAmountStringValue.count)"
        } else {
            return String("Failed To Return Transaction Amount Character Length")
        }
        
    }
    var transactionAmountString : String {
        return "\(transactionAmountStringID)\(transactionAmountStringCharLength)\(transactionAmountStringValue)"
    }
        
        
    //Country Code (2 Letters)
    let countryCodeStringID = "58"
    let countryCodeStringValue = "SG"
    var countryCodeStringCharLength : String {
        return "0\(countryCodeStringValue.count)"
    }
    var countryCodeString : String {
        return "\(countryCodeStringID)\(countryCodeStringCharLength)\(countryCodeStringValue)"
    }
        
        
    //Company Name
    let beneficiaryNameStringID = "59"
    var beneficiaryNameStringValue : String {
        return beneficiaryName
    }
    var beneficiaryNameStringCharLength : String {
        
        if beneficiaryNameStringValue.count >= 10 {
            return "\(beneficiaryNameStringValue.count)"
        } else if beneficiaryNameStringValue.count < 10 {
            return "0\(beneficiaryNameStringValue.count)"
        } else {
            return String("Failed To Return Beneficiary Name Character Length")
        }
        
    }
    var beneficiaryNameString : String {
        return "\(beneficiaryNameStringID)\(beneficiaryNameStringCharLength)\(beneficiaryNameStringValue)"
    }
        
        
    //Merchant City
    let merchantCityStringID = "60"
    let merchantCityStringValue = "Singapore"
    var merchantCityStringCharLength : String {
        
        if merchantCityStringValue.count >= 10 {
            return "\(merchantCityStringValue.count)"
        } else if merchantCityStringValue.count < 10 {
            return "0\(merchantCityStringValue.count)"
        } else {
            return String("Failed To Return Merchant City Character Length")
        }
        
    }
    var merchantCityString : String {
        return "\(merchantCityStringID)\(merchantCityStringCharLength)\(merchantCityStringValue)"
    }
        
        
    //Additional Data Fields Sub-Category : Actual Bill / Reference Number
    let referenceNumberStringID = "01"
    var referenceNumberStringValue : String {
        return referenceNumber
    }
    var referenceNumberStringCharLength : String {
        
        if referenceNumberStringValue.count >= 10 {
             return "\(referenceNumberStringValue.count)"
        } else if referenceNumberStringValue.count < 10 {
             return "0\(referenceNumberStringValue.count)"
        } else {
            return String("Failed To Return Reference Number String Character Length")
        }
        
    }
    var referenceNumberString : String {
        return "\(referenceNumberStringID)\(referenceNumberStringCharLength)\(referenceNumberStringValue)"
    }
        
    //Additional Data Fields (ID 62)
    let additionalDataFieldsStringID = "62"
    var additionalDataFieldsStringCharLength : String {
        
        if referenceNumberString.count >= 10 {
             return "\(referenceNumberString.count)"
        } else if referenceNumberString.count < 10 {
             return "0\(referenceNumberString.count)"
        } else {
            return String("Failed To Return Additional Data Fields Character Length")
        }
        
    }
    var additionalDataFieldsString : String {
        return "\(additionalDataFieldsStringID)\(additionalDataFieldsStringCharLength)\(referenceNumberString)"
    }
        
        
    //Checksum
    let checksumStringID = "63"
    let checksumStringCharLength = "04"
    var checksumString : String {
        return "\(checksumStringID)\(checksumStringCharLength)"
    }
        
        
    //PayNow QR Code String Without The CRC-16 Checksum
    var payNowQRCodeStringWithoutChecksumCRC16 : String {
        return "\(payloadFormatIndicatorString)\(pointOfInitiationMethodString)\(merchantAccountInfoTemplateString)\(merchantCategoryCodeString)\(currencyCodeString)\(transactionAmountString)\(countryCodeString)\(beneficiaryNameString)\(merchantCityString)\(additionalDataFieldsString)\(checksumString)"
    }
        
        
    //Calculating The CRC-16 / CCITT-FALSE Checksum
    func crc16CCITT_False(data: [UInt8],seed: UInt16 = 0x1d0f, final: UInt16 = 0xffff) -> UInt16{
        var crc = final
        data.forEach { (byte) in
            crc ^= UInt16(byte) << 8
            (0..<8).forEach({ _ in
                if (crc & UInt16(0x8000)) != 0 {
                        crc = (crc << 1) ^ 0x1021
                }
                else {
                        crc = crc << 1
                }
                //crc = (crc & UInt16(0x8000)) != 0 ? (crc << 1) ^ 0x1021 : crc << 1
            })
        }
        //return UInt16(crc ^ final)
        return UInt16(crc & final)
    }
        
    var array : [UInt8] {
        return Array(payNowQRCodeStringWithoutChecksumCRC16.utf8)
    }

    var ocrc : UInt16 {
        return crc16CCITT_False(data: array)
    }
    var lowercase_Checksum_CRC16_String : String {
        return String(ocrc, radix: 16)
    }
    var checksum_CRC16_String : String {
        return lowercase_Checksum_CRC16_String.uppercased()
    }
        
        
    //Final Pay Now QR Code String With Checksum
    public var finalPayNowQRString : String {
        return "\(payNowQRCodeStringWithoutChecksumCRC16)\(checksum_CRC16_String)"
    }
    
    
}
