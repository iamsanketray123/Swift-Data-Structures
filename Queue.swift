struct Queue<T> {

    class Node<T> {
        var value: T
        var next: Node?
        
        init(value: T, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }
    
    private var front: Node<T>?
    private var rear: Node<T>?
    private(set) var count: Int = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var peek: T? {
        return front?.value
    }
    
    mutating func enqueue(_ value: T) {
        let newNode = Node(value: value)
        if isEmpty {
            front = newNode
            rear = newNode
        } else {
            rear?.next = newNode
            rear = newNode
        }
        count += 1
    }
    
    mutating func dequeue() -> T? {
        guard let value = front?.value else { return nil }
        front = front?.next
        count -= 1
        
        if isEmpty {
            rear = nil  // Reset rear if queue is empty
        }
        
        return value
    }
    
    func printQueue() {
        var current = front
        var result: [T] = []
        
        while let node = current {
            result.append(node.value)
            current = node.next
        }
        
        print(result.map { "\($0)" }.joined(separator: " -> "))
    }
}
