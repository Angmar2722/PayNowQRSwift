import XCTest
@testable import PayNowQRSwift

final class PayNowQRSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PayNowQRStringStruct(beneficiaryType_: .UEN, beneficiary_: "201101550Z", beneficiaryName_: "Qryptal", amount_: "50.00", reference_: "AJ", amountIsEditable_: false, expiryDate_: "20201127").finalPayNowQRString, "00020101021226490009SG.PAYNOW010120210201101550Z03010040820201127520400005303702540550.005802SG5907Qryptal6009Singapore62060102AJ630488E9")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
