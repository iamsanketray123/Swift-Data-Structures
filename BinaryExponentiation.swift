func binaryExponentiation(base: Int, exponent: Int) -> Int {
    var result = 1
    var a = base
    var b = exponent
    
    while b > 0 {
        // If the current power is odd, multiply the result by the base
        if b % 2 == 1 {
            result *= a
        }
        // Square the base and halve the exponent
        a *= a
        b /= 2
    }
    
    return result
}
