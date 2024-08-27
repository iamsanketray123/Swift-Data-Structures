class Node {
    var value: Int
    var next: Node?
    var prev: Node?

    init(_ value: Int) {
        self.value = value
    }
}

class Deque {
    var head: Node?
    var tail: Node?

    func isEmpty() -> Bool {
        return head == nil
    }

    func pushFront(_ value: Int) {
        let newNode = Node(value)
        if let head = head {
            newNode.next = head
            head.prev = newNode
        } else {
            tail = newNode
        }
        head = newNode
    }

    func pushBack(_ value: Int) {
        let newNode = Node(value)
        if let tail = tail {
            newNode.prev = tail
            tail.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    func popFront() -> Int? {
        guard let head = head else { return nil }
        let value = head.value
        self.head = head.next
        head.next?.prev = nil
        if head.next == nil { // If there's no next node, tail should be nil
            tail = nil
        }
        return value
    }

    func popBack() -> Int? {
        guard let tail = tail else { return nil }
        let value = tail.value
        self.tail = tail.prev
        tail.prev?.next = nil
        if tail.prev == nil { // If there's no previous node, head should be nil
            head = nil
        }
        return value
    }

    func peekFront() -> Int? {
        return head?.value
    }

    func peekBack() -> Int? {
        return tail?.value
    }
}