import Foundation

public protocol NodeHolder {
    func pop() -> Int?
    func push(_ node: Int)
}

public class BaseDataStructure {
    var internalArray = [Int]()
    
    public init() {}
    
    public func pop() -> Int? {
        if !internalArray.isEmpty {
            return internalArray.removeFirst()
        }
        
        return nil
    }
}

public class Stack: BaseDataStructure, NodeHolder {
    public func push(_ node: Int) {
        internalArray.insert(node, at: 0)
    }
}

public class Queue: BaseDataStructure, NodeHolder {
    public func push(_ node: Int) {
        internalArray.append(node)
    }
}
