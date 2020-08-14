import XCTest
@testable import PayNowQRSwift

final class PayNowQRSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PayNowQRString(_beneficiaryType: .UEN, _beneficiary: "201101550Z", _beneficiaryName: "Qryptal", amount: "50.00", reference: "AJ", amountIsEditable: false, _expiryDate: "20201127").finalPayNowQRString, "00020101021226490009SG.PAYNOW010120210201101550Z03010040820201127520400005303702540550.005802SG5907Qryptal6009Singapore62060102AJ630488E9")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
