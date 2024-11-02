struct Heap<T: Comparable> {
    private var elements: [T]
    private let sort: (T, T) -> Bool

    init(sort: @escaping (T, T) -> Bool, elements: [T] = []) {
        self.sort = sort
        self.elements = elements
        if !self.elements.isEmpty {
            // Build the heap
            for index in (0..<(self.elements.count / 2)).reversed() {
                heapifyDown(from: index)
            }
        }
    }

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var count: Int {
        return elements.count
    }

    func peek() -> T? {
        return elements.first
    }

    mutating func insert(_ value: T) {
        elements.append(value)
        heapifyUp(from: elements.count - 1)
    }

    mutating func remove() -> T? {
        guard !elements.isEmpty else { return nil }
        elements.swapAt(0, elements.count - 1)
        let value = elements.removeLast()
        if !elements.isEmpty {
            heapifyDown(from: 0)
        }
        return value
    }

    private mutating func heapifyUp(from index: Int) {
        var childIndex = index
        let child = elements[childIndex]
        var parentIndex = (childIndex - 1) / 2

        while childIndex > 0 && sort(child, elements[parentIndex]) {
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
            parentIndex = (childIndex - 1) / 2
        }
        elements[childIndex] = child
    }

    private mutating func heapifyDown(from index: Int) {
        var parentIndex = index

        while true {
            let leftChildIndex = 2 * parentIndex + 1
            let rightChildIndex = 2 * parentIndex + 2
            var swapIndex = parentIndex

            // Compare with left child
            if leftChildIndex < elements.count && sort(elements[leftChildIndex], elements[swapIndex]) {
                swapIndex = leftChildIndex
            }

            // Compare with right child
            if rightChildIndex < elements.count && sort(elements[rightChildIndex], elements[swapIndex]) {
                swapIndex = rightChildIndex
            }

            // If no swaps needed, break out
            if swapIndex == parentIndex { return }

            elements.swapAt(parentIndex, swapIndex)
            parentIndex = swapIndex
        }
    }
}
