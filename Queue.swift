// class Node<T> {
    
//     var value: T
//     var next: Node?
    
//     init(value: T, next: Node? = nil) {
//         self.value = value
//         self.next = next
//     }
// }

// struct Queue<T> {
    
//     var front: Node<T>?
    
//     var rear: Node<T>?
    
//     init() { }
    
//     var isEmpty: Bool {
//         return front == nil
//     }
    
//     var peek: T? {
//         return front?.value
//     }
// }

// extension Queue {
    
//     mutating private func push(_ value: T) {
//         front = Node(value: value, next: front)
//         if rear == nil {
//             rear = front
//         }
//     }
    
//     mutating func enqueue(_ value: T) {
//         if isEmpty {
//             self.push(value)
//             return
//         }
        
//         rear?.next = Node(value: value)
//         rear = rear?.next
//     }
    
//     mutating func dequeue() -> T? {
//         defer {
//             front = front?.next
//             if isEmpty {
//                 rear = nil
//             }
//         }
//         return front?.value
//     }
// }

class Node<T> {

  // MARK: - Variables
  var value:T
  var next:Node?
    
  // MARK: - Initialisation Methods  
  init(value:T) {
    self.value = value
  }
}

class Queue<T> {
    
  // MARK: - Variables  
  var tail:Node<T>?
  var head:Node<T>?
  var count:Int = 0
  var isEmpty: Bool {
      return count == 0
  }

  // MARK: - Helper Methods  
  func dequeue() -> Node<T>? {
    if let node = head {
      head = head?.next
      count -= 1
      return node
    }
    return nil
  }
    
  func enqueue(_ value:T) {
    let newNode = Node(value:value)
    if let tailNode = tail {
      tailNode.next = newNode
      newNode.next = nil
      tail = newNode
    } else {
      head = newNode
      tail = newNode
    }
    count += 1
  }
    
}
