func binaryExponentiation(_ base: Int, _ exponent: Int, mod: Int = 1_000_000_007) -> Int {
    var result = 1
    var a = base % mod
    var b = exponent
    
    while b > 0 {
        // If the current power is odd, multiply the result by the base
        if b % 2 == 1 {
            result = (result * a) % mod
        }
        // Square the base and halve the exponent
        a = (a * a) % mod
        b /= 2
    }
    
    return result
}
