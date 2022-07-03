    func binarySearch(_ arr: [Int], _ target: Int) -> Int {

        var left = 0
        var right = arr.count-1
        var ans = -1
        while left <= right {
            
            let mid = left + (right-left) / 2 

            if arr[mid] == target {
                return mid
            }
            if arr[mid] > target {
                right = mid - 1
            } else {
                ans = mid
                left = mid + 1
            }
        }
        return ans
    }
