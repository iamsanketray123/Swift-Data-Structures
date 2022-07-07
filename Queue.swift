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
    
    init() { }
    
    var isEmpty: Bool {
        return front == nil
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
    }
    
    mutating func enqueue(_ value: T) {
        if isEmpty {
            self.push(value)
            return
        }
        
        rear?.next = Node(value: value)
        rear = rear?.next
    }
    
    mutating func dequeue() -> T? {
        defer {
            front = front?.next
            if isEmpty {
                rear = nil
            }
        }
        return front?.value
    }
}

