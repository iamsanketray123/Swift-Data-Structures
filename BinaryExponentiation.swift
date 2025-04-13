func binaryExponentiation(_ base: Int, _ exponent: Int, mod: Int = 1_000_000_007) -> Int {
    if exponent == 0 { return 1 }

    let half = binaryExponentiation(base, exponent / 2, mod: mod)
    let squared = (half * half) % mod

    if exponent % 2 == 0 {
        return squared
    } else {
        return (squared * (base % mod)) % mod
    }
}
