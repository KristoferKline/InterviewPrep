import UIKit

class Node<T> {
    var value: T
    var next: Node<T>?
    
    var combinedString: String {
        return "\(value)-" + (next?.combinedString ?? "> end")
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func insert(_ value: T) {
        next?.insert(value) ?? (next = Node(value))
    }
    
    func reverse(previous: Node?, newHead: inout Node?) {
        next?.reverse(previous: self, newHead: &newHead)
        if next == nil { newHead = self }
        next = previous
    }
}

class LinkedList<T> {
    var head: Node<T>?
    
    var string: String {
        return head?.combinedString ?? "No head"
    }
    
    func reverse() {
        head?.reverse(previous: nil, newHead: &head)
    }
    
    func insert(_ value: T) {
        head?.insert(value) ?? (head = Node(value))
    }
}

let list = LinkedList<Int>()
(1 ... 10).forEach { list.insert($0) }
list.string
list.reverse()
list.string
