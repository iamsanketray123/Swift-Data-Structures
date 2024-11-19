class Node<T> {
    var value: T
    var next: Node?
    var prev: Node?

    init(_ value: T) {
        self.value = value
    }
}

class Deque<T> {
    private(set) var count: Int = 0 // Tracks the number of elements
    var head: Node<T>?
    var tail: Node<T>?

    func isEmpty() -> Bool {
        return count == 0
    }

    func pushFront(_ value: T) {
        let newNode = Node(value)
        if let head = head {
            newNode.next = head
            head.prev = newNode
        } else {
            tail = newNode
        }
        head = newNode
        count += 1
    }

    func pushBack(_ value: T) {
        let newNode = Node(value)
        if let tail = tail {
            newNode.prev = tail
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
        count += 1
    }

    func popFront() -> T? {
        guard let head = head else { return nil }
        let value = head.value
        self.head = head.next
        head.next?.prev = nil
        if head.next == nil { // If there's no next node, tail should be nil
            tail = nil
        }
        count -= 1
        return value
    }

    func popBack() -> T? {
        guard let tail = tail else { return nil }
        let value = tail.value
        self.tail = tail.prev
        tail.prev?.next = nil
        if tail.prev == nil { // If there's no previous node, head should be nil
            head = nil
        }
        count -= 1
        return value
    }

    func peekFront() -> T? {
        return head?.value
    }

    func peekBack() -> T? {
        return tail?.value
    }
}
