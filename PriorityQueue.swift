enum HeapType {
    case max, min
}

struct PriorityQueue {
    private var heap: [Int]
    private let type: HeapType

    init(heap: [Int] = [], type: HeapType = .max) {
        self.heap = PriorityQueue.buildHeap(from: heap, type: type)
        self.type = type
    }

    private static func buildHeap(from array: [Int], type: HeapType) -> [Int] {
        var heap = array
        for i in (0 ..< heap.count / 2).reversed() {
            heap.siftDown(from: i, type: type)
        }
        return heap
    }

    func isEmpty() -> Bool {
        return heap.isEmpty
    }

    func peek() -> Int? {
        return heap.first
    }

    func insert(_ value: Int) {
        heap.append(value)
        heap.siftUp(from: heap.count - 1, type: type)
    }

    func poll() -> Int? {
        guard !heap.isEmpty else { return nil }
        heap.swapAt(0, heap.count - 1)
        let result = heap.removeLast()
        heap.siftDown(from: 0, type: type)
        return result
    }

    private mutating func siftUp(from index: Int, type: HeapType) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && shouldSwap(heap[child], heap[parent], type) {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int, type: HeapType) {
        var parent = index
        while true {
            let leftChild = 2 * parent + 1
            let rightChild = 2 * parent + 2
            var candidate = parent
            if leftChild < heap.count && shouldSwap(heap[leftChild], heap[candidate], type) {
                candidate = leftChild
            }
            if rightChild < heap.count && shouldSwap(heap[rightChild], heap[candidate], type) {
                candidate = rightChild
            }
            if candidate == parent {
                return
            }
            heap.swapAt(parent, candidate)
            parent = candidate
        }
    }

    private func shouldSwap(_ a: Int, _ b: Int, _ type: HeapType) -> Bool {
        switch type {
        case .max:
            return a > b
        case .min:
            return a < b
        }
    }
}
