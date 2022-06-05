import Foundation

public class RecursiveSearchImplementation: Search {
    public init() {}
    
    public func search(node: Int, graph: inout Graph) {
        graph.visitedNodes[node] = true
        
        graph.adjacencyLists[node]?.forEach { adjacentNode in
            if graph.visitedNodes[adjacentNode] == false {
                search(node: adjacentNode, graph: &graph)
            }
        }
    }
}

