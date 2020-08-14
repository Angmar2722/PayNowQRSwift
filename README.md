# PayNowQRSwift


**From the author :**

Hello! I am a high scool student who just learned to code. This is my first attempt at creating a Swift package. Please let me know how I can improve. Thanks :D


![PayNowSwiftQR: A library to help generate Pay Now QR Codes](https://raw.githubusercontent.com/Angmar2722/PayNowQRSwift/master/Images/PayNowLogo.jpg)


**Introduction :**

This library enables you to obtain the string value of a Pay Now QR Code by specifying its parameters. 


**Installation :**

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

This [video](https://www.youtube.com/watch?v=ZxHndSGmWcE) eloquently explains how to install Swift Packages.

After installing the Swift package, remember to type in `import PayNowQRSwift` in your Swift file.

**String Parameters :**

1. Beneficiary Type (Enum) (Mobile Phone Number Or UEN)
2. Beneficiary (String) (Actual UEN Or Mobile Phone Number, For Mobile Number Add +65 Before The Actual Number)
3. Beneficiary Name (String) (The Name Of The Company And Its Corresponding UEN Or The Name Of The Holder Of The Mobile Number)
4. Transaction Amount (String ) (The Amount To Be Paid)
5. Reference (String) (The Unique Identifier Assigned To Any Financial Transaction)
6. Amount Is Editable (Bool) (The Option To Let The Transaction Amount Be Edited Later On)
7. Expiry Date (Optional String) (The Expiry Date Of The QR Code)


**Creating The String :**

1. Beneficiary  (You can write .UEN or .Mobile)
2. Beneficiary (If the beneficiary is a mobile number, make sure it is in this format : "+65MobileNumber". If the beneficiary is a UEN, write the UEN as a String)
3. Beneficiary Name (A string identifying the beneficiary, could be a person or )
4. Transaction Amount (A string containing the amount)
5. Reference (Any string)
6. Amount Is Editable (If set to true, it allows the user to edit the transaction amount using their banking app etc. If it is false, the user cannot edit the amount)
7. Expiry Date (This is an optional string. If you want to leave it empty, write "nil". If you want to input a date, it has to be exactly in the YYYYMMDD format.)


The code snippets below show how to store the string in a constant / variable and shows the value of the string with the specified parameters.


```swift

let demo1 = PayNowQRString(_beneficiaryType: .UEN, _beneficiary: "S62SS0057G", _beneficiaryName: "Singapore Children's Society", amount: "10.00", reference: "Donation", amountIsEditable: false, _expiryDate: "20201217").finalPayNowQRString

print("The result of demo1 is : \(demo1)")

let demo2 = PayNowQRString(_beneficiaryType: .Mobile, _beneficiary: "+6512345678", _beneficiaryName: "John Lee", amount: "10.27", reference: "Mr. Lee Bill", amountIsEditable: true, _expiryDate: "nil").finalPayNowQRString

print("The result of demo1 is : \(demo2)")

```


`The result of demo1 is : 00020101021226490009SG.PAYNOW010120210201023709H03010040820201127520400005303702540550.005802SG5930Singapore Engineering Services6009Singapore62220118SES Monday Payment6304763F`
`The result of demo2 is : 00020101021226380009SG.PAYNOW010100211+651234567803011520400005303702540510.275802SG5908John Lee6009Singapore62160112Mr. Lee Bill6304BD9B`



**Usage :**

The string obtained from this framework can then be inputted into a function for creating the QR Code.

The code snippet below shows how you can pass this string into a standard function which generates a QR Code. The QR Code produced is the final Pay Now QR Code.


```swift

func generateQRCode(from string: String, with imageView: UIImageView) -> UIImage? {
    
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")

        guard let qrImage = filter.outputImage else {return nil}
        let scaleX = imageView.frame.size.width / qrImage.extent.size.width
        let scaleY = imageView.frame.size.height / qrImage.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

        
        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }
    return nil
    
}

let demoImageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
let qrCodeImage = generateQRCode(from: demo1, with: demoImageView)

```

The Pay Now QR Code Image generated with the demo1 constant is shown below :

![Demo 1 QR Code](https://raw.githubusercontent.com/Angmar2722/PayNowQRSwift/master/Images/demo1QR.jpeg)




