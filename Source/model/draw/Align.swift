open class Align: @unchecked Sendable {

    public static let min: Align = Align()
    public static let mid: Align = MidAlign()
    public static let max: Align = MaxAlign()

    open func align(outer: Double, inner: Double) -> Double {
        return 0
    }

    open func align(size: Double) -> Double {
        return align(outer: size, inner: 0)
    }

}

private class MidAlign: Align, @unchecked Sendable {

    override func align(outer: Double, inner: Double) -> Double {
        return (outer - inner) / 2
    }
}

private class MaxAlign: Align, @unchecked Sendable {

    override func align(outer: Double, inner: Double) -> Double {
        return outer - inner
    }
}
