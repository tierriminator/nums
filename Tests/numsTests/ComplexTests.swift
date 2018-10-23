import XCTest
import nums

class ComplexTests: XCTestCase {
    static var allTests = [
        ("testInitialization", testInitialization),
        ("testConversion", testConversion),
        ("testMultiplication", testMultiplication),
        ("testDivision", testDivision),
        ("testAddition", testAddition),
        ("testSubtraction", testSubtraction),
        ("testEquality", testEquality)
        ]
    
    func testInitialization() {
        // test the initialization, especially for arbitrary phi
        XCTAssert(Complex(rad: 1, phi: Double.pi/2).phi ~= Double.pi/2)
        XCTAssert(Complex(rad: 1, phi: 3*Double.pi).phi ~= Double.pi)
        XCTAssert(Complex(rad: 1, phi: -Double.pi/2).phi ~= Double.pi/2*3)
        XCTAssert(Complex(rad: 1, phi: -3*Double.pi).phi ~= Double.pi)
    }
    
    func testConversion() {
        let c1 = Complex(real: 1, im: 1)
        let c2 = Complex(real: 2, im: 2)
        XCTAssertEqual(c1.phi, c2.phi)
        XCTAssert(c1.rad ~= sqrt(2))
        XCTAssert(c2.rad ~= sqrt(8))
        let c3 = Complex(rad: 0, phi: 3)
        XCTAssert(c3.real ~= 0)
        XCTAssert(c3.im ~= 0)
        let c4 = Complex(rad: 1, phi: Double.pi/4)
        XCTAssert(c4.im ~= c4.real)
        XCTAssert(c4.im ~= sqrt(0.5))
        let c5 = Complex(real: -1, im: 0)
        XCTAssert(c5.rad ~= 1 && c5.phi ~= Double.pi)
    }
    
    func testMultiplication() {
        let c1 = Complex(real: 1, im: 1)
        let c2 = Complex(real: 2, im: 2)
        XCTAssertEqual(c1 * c2, Complex(real: 0, im: 4))
        XCTAssertEqual(c1 * c2, c1 ° c2)
        XCTAssertEqual(c1 * 0, Complex(real: 0, im: 0))
        XCTAssertEqual(c2 * 2, 2 * c2)
        XCTAssertEqual(c1 * 2, c2)
        XCTAssertEqual(c1 ° 0, Complex(real: 0, im: 0))
        XCTAssertEqual(c2 ° 2, 2 ° c2)
        XCTAssertEqual(c1 ° 2, c2)
    }
    
    func testDivision() {
        let c1 = Complex(real: 0, im: 4)
        let c2 = Complex(real: 2, im: 2)
        XCTAssertEqual(c1 / c2, Complex(real: 1, im: 1))
        XCTAssertEqual(c2 / 2, Complex(real: 1, im: 1))
        XCTAssertEqual(4 / Complex(real: -2, im: 0), Complex(real: -2, im: 0))
    }
    
    func testAddition() {
        let c1 = Complex(real: 1, im: 1)
        let c2 = Complex(real: 2, im: 2)
        XCTAssertEqual(c1 + c2, Complex(real: 3, im: 3))
        XCTAssertEqual(c1 + 2, Complex(real: 3, im: 1))
        XCTAssertEqual(c1 + 2, 2 + c1)
    }
    
    func testSubtraction() {
        let c1 = Complex(real: 1, im: 1)
        let c2 = Complex(real: 2, im: 2)
        XCTAssertEqual(c2 - c1, c1)
        XCTAssertEqual(c1 - 2, Complex(real: -1, im: 1))
        XCTAssertEqual(c1 - 2, -(2 - c1))
    }
    
    func testEquality() {
        let c1 = Complex(real: 12, im: -0.5)
        let c2 = Complex(real: 11, im: 0)
        XCTAssert(equals(c1, c2, tol: 1.5))
        let c3 = Complex(rad: 2, phi: -3)
        let c4 = Complex(rad: 4.5, phi: 1.5)
        XCTAssert(equals(c3, c4, tol: 6.5))
        XCTAssert(c2 == 11.0)
        XCTAssert(11.0 == c2)
    }
}
