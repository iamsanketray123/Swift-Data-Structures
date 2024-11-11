    func sieve(_ num: Int) -> [Int] {
        var primes = Array(repeating: true, count: num)
        for i in 2..<(Int(sqrt(Double(num)))) where primes[i] {
            var j = i*i
            while j < num {
                defer { j += i }
                primes[j] = false
            }
        }
        var ans = [Int]()
        for i in 2..<primes.count {
            if primes[i] { ans.append(i) }
        }
        return ans
    }
