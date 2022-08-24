    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var xor = x^y
        var distance = 0
        
        while xor != 0 {
            distance += 1
            xor &= (xor-1)
        }
        
        return distance
    }
