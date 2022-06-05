import Foundation

public protocol Graph {
    var adjacencyLists: [Int : [Int]] { get set }
    var visitedNodes: [Int : Bool] { get set }
    var nextDisconnectedNode: Int? { get }
}

public class GraphImplementation: Graph {
    public var adjacencyLists = [Int : [Int]]()
    public var visitedNodes = [Int : Bool]()
    
    public init() {}
    
    public var nextDisconnectedNode: Int? {
        get {
            for node in adjacencyLists.keys {
                if let visited = visitedNodes[node] {
                    if visited == false {
                        return node
                    }
                }
            }
            return nil
        }
    }
}

public protocol GraphBuilder {
    func addEdge(startingPoint: Int, endingPoint: Int)
    func build() -> Graph
}

public class GraphBuilderImplementation {
    private var graph = GraphImplementation()
    public init() {}
}

extension GraphBuilderImplementation: GraphBuilder {
    public func build() -> Graph {
        return graph
    }
    
    public func addEdge(startingPoint: Int, endingPoint: Int) {
        graph.visitedNodes[startingPoint] = false
        if var list = graph.adjacencyLists[startingPoint] {
            list.append(endingPoint)
            graph.adjacencyLists[startingPoint] = list
        } else {
            graph.adjacencyLists[startingPoint] = [endingPoint]
        }
    }
}


