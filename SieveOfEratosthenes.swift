    func sieve(_ num: Int) -> [Int] {
        var primes = Array(repeating: true, count: num)
        var ans = [Int]()
        
        for i in 2..<Int(sqrt(Double(num))) where primes[i] {
            for j in stride(from: i*i, to: num, by: i) {
                primes[j] = false
            }
        }
        
        for i in 2..<primes.count where primes[i] {
            ans.append(i)
        }
        
        return ans
    }
