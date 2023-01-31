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
        return value
    }

    func popBack() -> Int? {
        guard let tail = tail else { return nil }
        let value = tail.value
        self.tail = tail.prev
        tail.prev?.next = nil
        return value
    }
}


/*

let deque = Deque()

// Adding elements to front
deque.pushFront(1)
deque.pushFront(2)
deque.pushFront(3)

// Adding elements to back
deque.pushBack(4)
deque.pushBack(5)

// Removing elements from front
print(deque.popFront()!) // 3
print(deque.popFront()!) // 2

// Removing elements from back
print(deque.popBack()!) // 5
print(deque.popBack()!) // 4

// Checking if deque is empty
print(deque.isEmpty()) // false
print(deque.popFront()!) // 1
print(deque.isEmpty()) // true

*/
