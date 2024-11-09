func primeFactors(_ number: Int) -> Set<Int> {
        var n = number
        var factors = Set<Int>()

        // Check for the number of 2s that divide n
        while n % 2 == 0 {
            factors.insert(2)
            n /= 2
        }

        // n must be odd at this point, so start from 3 and increment by 2
        var i = 3
        while i * i <= n {
            // While i divides n, add i and divide n
            while n % i == 0 {
                factors.insert(i)
                n /= i
            }
            i += 2
        }

        // This condition is to check if n is a prime number greater than 2
        if n > 2 {
            factors.insert(n)
        }

        return factors
    }
