//
//  Complex.swift
//  nums
//
//  Created by Tierry Hörmann on 23.08.18.
//

import Foundation

/**
 A struct for representing complex numbers. Two formats are supported:
 - **standard format** `a + ib`
 - **polar format** `r*exp(i*x)`
 An instance can be initialized from either of the two formats and conversion happens lazily, i.e. when the respecitve fields are accessed.
 A new operator `°` is introduced, which performs complex multiplication based on polar format, while standard multiplication `*` is based on standard format.
 */
public struct Complex {
    
    /** class which serves for lazy initialization */
    private class Cache {
        var real: Double?
        var im: Double?
        var rad: Double?
        var phi: Double?
    }
    
    private let cache = Cache()
    
    // the components of a complex number in the two notations

    /** The real value of the complex number */
    public var real: Double {
        if cache.real == nil {
            cache.real = rad*cos(phi)
        }
        return cache.real!
    }
    /** The imaginary value of the complex number */
    public var im: Double {
        if cache.im == nil {
            cache.im = rad*sin(phi)
        }
        return cache.im!
    }
    /** The radius of the complex number in polar format */
    public var rad: Double {
        if cache.rad == nil {
            cache.rad = sqrt(real*real + im*im)
        }
        return cache.rad!
    }
    /** The angle of the complex number in polar format */
    public var phi: Double {
        if cache.phi == nil {
            var tmp = atan(im/real)
            if real < 0 {
                tmp = Double.pi + tmp
            } else if im < 0 {
                tmp = 2*Double.pi + tmp
            }
            cache.phi = tmp
        }
        return cache.phi!
    }
    
    /** Initialize from real and imaginary values */
    public init(real: Double, im: Double) {
        cache.real = real
        cache.im = im
    }
    
    /** Initialize from polar coordinates */
    public init(rad: Double, phi: Double) {
        cache.rad = rad
        // convert phi to the right form
        let twoPi = 2*Double.pi
        var floorDiv = floor(abs(phi/twoPi))
        if phi < 0 {
            floorDiv = -floorDiv
        }
        let tmp = phi - floorDiv*twoPi
        cache.phi = tmp < 0 ? twoPi + tmp : tmp
    }
}

/** Compares two complex numbers for equality, based on a given tolerance for the euclidean distance */
public func equals(_ lhs: Complex, _ rhs: Complex, tol: Double = nums_tolerance) -> Bool {
    return (lhs - rhs).rad < tol
}

extension Complex: Equatable {
    
    /** standard form comparison with nums_tolerance as tolerance */
    public static func ==(_ lhs: Complex, _ rhs: Complex) -> Bool {
        return equals(lhs, rhs)
    }
    
    public static func ==(_ lhs: Complex, _ rhs: Double) -> Bool {
        return lhs.real ~= rhs && lhs.im ~= 0
    }
    
    public static func ==(_ lhs: Double, _ rhs: Complex) -> Bool {
        return lhs ~= rhs.real && 0 ~= rhs.im
    }
}

// standard form multiplication

/** Multiplies two complex numbers based on their standard format */
public func *(_ lhs: Complex, _ rhs: Complex) -> Complex {
    return Complex(real: lhs.real*rhs.real - lhs.im*rhs.im, im: lhs.im*rhs.real + lhs.real*rhs.im)
}

public func *(_ lhs: Double, _ rhs: Complex) -> Complex {
    return Complex(real: lhs*rhs.real, im: lhs*rhs.im)
}

public func *(_ lhs: Complex, _ rhs: Double) -> Complex {
    return rhs * lhs
}

// polar form multiplication

infix operator °: MultiplicationPrecedence
/** Multiplies two complex numbers, based on their polar form */
public func °(_ lhs: Complex, _ rhs: Complex) -> Complex {
    return Complex(rad: lhs.rad*rhs.rad, phi: lhs.phi+rhs.phi)
}

public func °(_ lhs: Double, _ rhs: Complex) -> Complex {
    return Complex(rad: lhs*rhs.rad, phi: rhs.phi)
}

public func °(_ lhs: Complex, _ rhs: Double) -> Complex {
    return rhs ° lhs
}

/** Adds two complex numbers. Addition happens in standard format. */
public func +(_ lhs: Complex, _ rhs: Complex) -> Complex {
    return Complex(real: lhs.real + rhs.real, im: lhs.im + rhs.im)
}

public func +(_ lhs: Complex, _ rhs: Double) -> Complex {
    return Complex(real: lhs.real + rhs, im: lhs.im)
}

public func +(_ lhs: Double, _ rhs: Complex) -> Complex {
    return Complex(real: rhs.real + lhs, im: rhs.im)
}

/** Subtracts two complex numbers. Subtraction happens in standard format */
public func -(_ lhs: Complex, _ rhs: Complex) -> Complex {
    return Complex(real: lhs.real - rhs.real, im: lhs.im - rhs.im)
}

public func -(_ lhs: Complex, _ rhs: Double) -> Complex {
    return Complex(real: lhs.real - rhs, im: lhs.im)
}

public func -(_ lhs: Double, _ rhs: Complex) -> Complex {
    return Complex(real: lhs - rhs.real, im: rhs.im)
}

public prefix func -(_ arg: Complex) -> Complex {
    return Complex(real: -arg.real, im: arg.im)
}

/** Divides two complex numbers. Division happens in polar format */
public func /(_ lhs: Complex, _ rhs: Complex) -> Complex {
    return Complex(rad: lhs.rad / rhs.rad, phi: lhs.phi - rhs.phi)
}

public func /(_ lhs: Complex, _ rhs: Double) -> Complex {
    return lhs / Complex(rad: abs(rhs), phi: rhs >= 0 ? 0 : Double.pi)
}

public func /(_ lhs: Double, _ rhs: Complex) -> Complex {
    return Complex(rad: abs(lhs), phi: lhs >= 0 ? 0 : Double.pi) / rhs
}


