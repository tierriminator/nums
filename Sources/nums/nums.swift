/** The numerical tolerance for the nums module, as used in comparison */
public var nums_tolerance: Double = 1e-5

/** Compares two doubles for equality, based on a given numerical tolerance */
public func equals(_ lhs: Double, _ rhs: Double, _ tol: Double = nums_tolerance) -> Bool {
    return abs(lhs-rhs) < tol
}

infix operator ~=: ComparisonPrecedence
/** Compares two doubles for equality, based on the default numerical tolerance */
public func ~=(_ lhs: Double, _ rhs: Double) -> Bool {
    return equals(lhs, rhs)
}
