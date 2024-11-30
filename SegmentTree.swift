/// A generic Segment Tree implementation in Swift
/// Supports range sum query and point update operations
/// Time Complexity: 
/// - Construction: O(n)
/// - Query: O(log n)
/// - Update: O(log n)
struct SegmentTree<T> {
    // The original input array
    private var array: [T]
    // The segment tree array
    private var tree: [T]
    // The operation used for range queries (e.g., sum, min, max)
    private var operation: (T, T) -> T
    
    /// Initialize the Segment Tree
    /// - Parameters:
    ///   - array: The input array
    ///   - defaultValue: The identity element for the operation (e.g., 0 for sum, Int.max for min)
    ///   - operation: The binary operation to use for range queries
    init(array: [T], defaultValue: T, operation: @escaping (T, T) -> T) {
        self.array = array
        // The tree size is typically 4 times the input array size to ensure enough space
        self.tree = Array(repeating: defaultValue, count: array.count * 4)
        self.operation = operation
        
        // Build the segment tree
        buildTree(node: 0, start: 0, end: array.count - 1)
    }
    
    /// Recursively build the segment tree
    /// - Parameters:
    ///   - node: Current node index
    ///   - start: Start index of the current segment
    ///   - end: End index of the current segment
    private mutating func buildTree(node: Int, start: Int, end: Int) {
        // Base case: leaf node
        if start == end {
            tree[node] = array[start]
            return
        }
        
        // Recursively build left and right subtrees
        let mid = (start + end) / 2
        let leftNode = 2 * node + 1
        let rightNode = 2 * node + 2
        
        buildTree(node: leftNode, start: start, end: mid)
        buildTree(node: rightNode, start: mid + 1, end: end)
        
        // Combine results from left and right subtrees
        tree[node] = operation(tree[leftNode], tree[rightNode])
    }
    
    /// Query the range from left to right (inclusive)
    /// - Parameters:
    ///   - left: Left boundary of the query range
    ///   - right: Right boundary of the query range
    /// - Returns: Result of the query operation over the specified range
    mutating func query(left: Int, right: Int) -> T {
        return queryRecursive(node: 0, start: 0, end: array.count - 1, left: left, right: right)
    }
    
    /// Recursive helper method for range query
    /// - Parameters:
    ///   - node: Current node index
    ///   - start: Start index of the current segment
    ///   - end: End index of the current segment
    ///   - left: Left boundary of the query range
    ///   - right: Right boundary of the query range
    /// - Returns: Result of the query operation over the specified range
    private mutating func queryRecursive(node: Int, start: Int, end: Int, left: Int, right: Int) -> T {
        // Complete overlap
        if left <= start && end <= right {
            return tree[node]
        }
        
        // No overlap
        if right < start || left > end {
            // Return an identity value for the operation
            // For sum: return 0, for min: return Int.max, for max: return Int.min
            return tree[node]
        }
        
        // Partial overlap
        let mid = (start + end) / 2
        let leftNode = 2 * node + 1
        let rightNode = 2 * node + 2
        
        let leftResult = queryRecursive(node: leftNode, start: start, end: mid, left: left, right: right)
        let rightResult = queryRecursive(node: rightNode, start: mid + 1, end: end, left: left, right: right)
        
        return operation(leftResult, rightResult)
    }
    
    /// Update a specific index with a new value
    /// - Parameters:
    ///   - index: Index to update
    ///   - newValue: New value to set at the index
    mutating func update(index: Int, newValue: T) {
        updateRecursive(node: 0, start: 0, end: array.count - 1, index: index, newValue: newValue)
    }
    
    /// Recursive helper method for point update
    /// - Parameters:
    ///   - node: Current node index
    ///   - start: Start index of the current segment
    ///   - end: End index of the current segment
    ///   - index: Index to update
    ///   - newValue: New value to set at the index
    private mutating func updateRecursive(node: Int, start: Int, end: Int, index: Int, newValue: T) {
        // Base case: leaf node
        if start == end {
            array[index] = newValue
            tree[node] = newValue
            return
        }
        
        let mid = (start + end) / 2
        let leftNode = 2 * node + 1
        let rightNode = 2 * node + 2
        
        // Recursively update the appropriate subtree
        if index <= mid {
            updateRecursive(node: leftNode, start: start, end: mid, index: index, newValue: newValue)
        } else {
            updateRecursive(node: rightNode, start: mid + 1, end: end, index: index, newValue: newValue)
        }
        
        // Update current node by combining results of children
        tree[node] = operation(tree[leftNode], tree[rightNode])
    }
}

// Example usage
func demonstrateSegmentTree() {
    // Sum Segment Tree example
    var sumTree = SegmentTree(
        array: [1, 3, 5, 7, 9, 11],
        defaultValue: 0,
        operation: { $0 + $1 }
    )
    
    print("Sum of range [1, 3]: \(sumTree.query(left: 1, right: 3))")
    sumTree.update(index: 2, newValue: 10)
    print("Sum after updating index 2 to 10: \(sumTree.query(left: 1, right: 3))")
    
    // Min Segment Tree example
    var minTree = SegmentTree(
        array: [7, 2, 3, 0, 5, 10, -3],
        defaultValue: Int.max,
        operation: { min($0, $1) }
    )
    
    print("Min of range [2, 5]: \(minTree.query(left: 2, right: 5))")
    minTree.update(index: 4, newValue: -5)
    print("Min after updating index 4 to -5: \(minTree.query(left: 2, right: 5))")
}

// Uncomment to run the demonstration
// demonstrateSegmentTree()
