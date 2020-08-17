# PayNowQRSwift


**From the author :**

Hello! I am a high scool student who just learned to code. This is my first attempt at creating a Swift package. Please let me know how I can improve. Thanks :D


![PayNowSwiftQR: A library to help generate Pay Now QR Codes](https://raw.githubusercontent.com/Angmar2722/PayNowQRSwift/master/Images/PayNowLogo.jpg)


**Introduction :**

This library enables you to generate the following by specifying their parameters :

1. The string value of a Pay Now QR Code 
2. The Pay Now QR Code image  


<br/>


**Installation :**

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.

This [video](https://www.youtube.com/watch?v=ZxHndSGmWcE) eloquently explains how to install Swift Packages.

After installing the Swift package, remember to type in `import PayNowQRSwift` in your Swift file.


<br/>


**Pay Now QR Code String Generation :**


Call the function `payNowQRString` and pass in your values for the 7 parameters. The function returns a string which can then be stored in a constant / variable 


The table below shows you how to fill in the values for the Pay Now QR String. 


<br/>


**The String Parameter Table :**


| No. | String Parameter   | Data Type | What Is It ?                                                                                         | Format                                                                                                                                            |
|-----|--------------------|-----------|------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| 1   | Beneficiary Type   | Enum      | Specifies Whether It Is A Mobile Number Or UEN                                                       | You can write either .UEN or .Mobile                                                                                                              |
| 2   | Beneficiary        | String    | The actual UEN or Mobile Number Value                                                                | If the beneficiary is a mobile number, make sure it is in this format : "+65MobileNumber". If the beneficiary is a UEN, write the UEN as a String |
| 3   | Beneficiary Name   | String    | The Name Of The Organisation And Its Corresponding UEN Or The Name Of The Owner Of The Mobile Number | (A string identifying the beneficiary, could be a person or organisation                                                                          |
| 4   | Transaction Amount | CG Float  | The Amount To Be Paid                                                                                | The number you type in has to have less than 13 characters and has to be positive.                                                                |
| 5   | Reference          | String    | The Unique Identifier Assigned To Any Financial Transaction                                          | Any string                                                                                                                                        |
| 6   | Amount Is Editable | Bool      | The Option To Let The Transaction Amount Be Edited Later On                                          | If set to true, it allows the user to edit the transaction amount using their banking app etc. If it is false, the user cannot edit the amount    |
| 7   | Expiry Date        | Date      | The Expiry Date Of The QR Code                                                                       | This is an optional string. If you want to leave it empty, write nil. Otherwise, any date can be inputted.                                        |


The code snippets below show how to store the string in a constant / variable and shows the value of the string with the specified parameters when printed.


```swift

let demo1 = payNowQRString(_beneficiaryType: .UEN, _beneficiary: "S62SS0057G", _beneficiaryName: "Singapore Children's Society", amount: 10, reference: "Donation", amountIsEditable: false, _expiryDate: Date.init() )

print("The result of demo1 is : ", demo1)


let demo2 = payNowQRString(_beneficiaryType: .Mobile, _beneficiary: "+6512345678", _beneficiaryName: "John Lee", amount: 10.27, reference: "Mr. Lee Bill", amountIsEditable: true, _expiryDate: nil)

print("The result of demo2 is : ", demo2)

```

<br/>


`The result of demo1 is :  00020101021226490009SG.PAYNOW010120210S62SS0057G03010040820200817520400005303702540510.005802SG5928Singapore Children's Society6009Singapore62120108Donation630482EB`


<br/>


`The result of demo2 is :  00020101021226380009SG.PAYNOW010100211+651234567803011520400005303702540510.275802SG5908John Lee6009Singapore62160112Mr. Lee Bill6304BD9B`


<br/>


**Usage :**

The string obtained from this framework can then be inputted into a function for creating the QR Code.

The code snippet below shows how you can pass this string into a standard function which generates a QR Code. The QR Code produced is the final Pay Now QR Code.


<br/>


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


<br/>


The Pay Now QR Code Image generated with the demo1 constant is shown below :

![Demo 1 QR Code](https://raw.githubusercontent.com/Angmar2722/PayNowQRSwift/master/Images/demo1QR.jpeg)


<br/>


**Pay Now QR Code Image  Generation :**

Aside from returning the string for a Pay Now QR Code, this framework also allows you to quickly create the standard Pay Now QR Code image (with its distinctive purple colour as well as having the Pay Now Logo). 

Apart from providing you with an image, the framework also allows you to write some text below the QR Code to convey some information without scanning (this is optional).

To create the image, call the function `payNowQRImage` and pass in your values for the 9 parameters (The first 7 parameters are the same as for creating the string). The function returns a UIImage.


The table below shows you how to fill in the values for the Pay Now QR Image generation function.


<br/>


**The Image Parameter Table :**


| No. | Image Parameter        | Data Type                             | What Is It ?                                                                    | Format                                                                             |
|-----|------------------------|---------------------------------------|---------------------------------------------------------------------------------|------------------------------------------------------------------------------------|
| 1-7 | String Parameters      | Refer To The String Parameters Table  | Refer To The String Parameters Table                                            | Refer To The String Parameters Table                                               |
| 8   | QR Code Width & Height | CG Float                              | The width or height of the QR Code (Since it is a square, both sides are equal) | Any positive number                                                                |
| 9   | Bottom Label Text      | String                                | A label below the QR Code displaying relevant information.                      | Any text (Be it a number or a string). If you want to remove the label, write nil. |


<br/>


**Usage  :**


The code snippets below show how you can pass in different values for the image parameters to create different images.


<br/>


```swift

let qrImage1 = payNowQRImage(_beneficiaryType: .UEN, _beneficiary: "S62SS0057G", _beneficiaryName: "SCS", amount: 11.5, reference: "Monthly Donation", amountIsEditable: false, _expiryDate: Date.init(), qrWidthAndHeight: 257.155, bottomLabelText: "SCS (*057G) $11.5")


let qrImage2 = payNowQRImage(_beneficiaryType: .UEN, _beneficiary: "S62SS0057G", _beneficiaryName: "SCS", amount: 11.5, reference: "Monthly Donation", amountIsEditable: true, _expiryDate: nil, qrWidthAndHeight: 257.155, bottomLabelText: nil)

```

<br/>


The above images (qrImage1 and qrImage2) have one major difference. The first image contains a bottom label with the specified text while the second image does not. 

After adding the images to an image view and then running it on a simulator, here are the results.


<br/>


**qrImage1  :**

![qrImage1](https://raw.githubusercontent.com/Angmar2722/PayNowQRSwift/master/Images/qrImage1.png)


<br/>


**qrImage2  :**

![qrImage2](https://raw.githubusercontent.com/Angmar2722/PayNowQRSwift/master/Images/qrImage2.png)


<br/>


**Note  :**
The Pay Now QR Image generation function returns a clear image when the width / height of the QR code is equal to the width and height of the UIImageView it is added to.
