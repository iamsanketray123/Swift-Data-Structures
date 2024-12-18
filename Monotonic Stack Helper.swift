import Foundation

class MonotonicStackHelper {
    /// Finds the next larger element for each element in the array
    /// - Parameter nums: Input array of integers
    /// - Returns: Array where each index contains the next larger element, or -1 if no such element exists
    static func findNextLargerElements(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var stack = [Int]() // Stack to store indices
        
        for (index, num) in nums.enumerated() {
            // Pop indices from stack while current element is larger
            while let lastIndex = stack.last, nums[lastIndex] < num {
                result[stack.removeLast()] = num
            }
            
            // Push current index to stack
            stack.append(index)
        }
        
        return result
    }
    
    /// Finds the previous larger element for each element in the array
    /// - Parameter nums: Input array of integers
    /// - Returns: Array where each index contains the previous larger element, or -1 if no such element exists
    static func findPreviousLargerElements(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var stack = [Int]() // Stack to store indices
        
        for (index, num) in nums.enumerated().reversed() {
            // Pop indices from stack while current element is larger
            while let lastIndex = stack.last, nums[lastIndex] < num {
                result[stack.removeLast()] = num
            }
            
            // Push current index to stack
            stack.append(index)
        }
        
        return result
    }
    
    /// Finds the next smaller element for each element in the array
    /// - Parameter nums: Input array of integers
    /// - Returns: Array where each index contains the next smaller element, or -1 if no such element exists
    static func findNextSmallerElements(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var stack = [Int]() // Stack to store indices
        
        for (index, num) in nums.enumerated() {
            // Pop indices from stack while current element is smaller
            while let lastIndex = stack.last, nums[lastIndex] > num {
                result[stack.removeLast()] = num
            }
            
            // Push current index to stack
            stack.append(index)
        }
        
        return result
    }
    
    /// Finds the previous smaller element for each element in the array
    /// - Parameter nums: Input array of integers
    /// - Returns: Array where each index contains the previous smaller element, or -1 if no such element exists
    static func findPreviousSmallerElements(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: -1, count: nums.count)
        var stack = [Int]() // Stack to store indices
        
        for (index, num) in nums.enumerated().reversed() {
            // Pop indices from stack while current element is smaller
            while let lastIndex = stack.last, nums[lastIndex] > num {
                result[stack.removeLast()] = num
            }
            
            // Push current index to stack
            stack.append(index)
        }
        
        return result
    }
}
