class Node<T> {
    
    var value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

struct Queue<T> {
    
    var front: Node<T>?
    var rear: Node<T>?
    private(set) var count: Int = 0 // Track the count of elements in the queue
    
    init() { }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var peek: T? {
        return front?.value
    }
}

extension Queue {
    
    mutating private func push(_ value: T) {
        front = Node(value: value, next: front)
        if rear == nil {
            rear = front
        }
        count += 1
    }
    
    mutating func enqueue(_ value: T) {
        if isEmpty {
            self.push(value)
            return
        }
        
        rear?.next = Node(value: value)
        rear = rear?.next
        count += 1
    }
    
    mutating func dequeue() -> T? {
        guard let value = front?.value else { return nil }

        front = front?.next
        count -= 1

        if isEmpty {
            rear = nil
        }

        return value
    }
}

extension Queue {
    func printQueue() {
        var current = front
        var result: [T] = []
        
        while current != nil {
            result.append(current!.value)
            current = current?.next
        }
        
        print(result.map { "\($0)" }.joined(separator: " -> "))
    }
}
