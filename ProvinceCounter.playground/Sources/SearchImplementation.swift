import Foundation

public protocol Search {
    func search(node: Int, graph: inout Graph)
}

public class SearchImplementation: Search {
    private var nodeHolder: NodeHolder
    private var graph: Graph = GraphImplementation()
    
    public init(nodeHolder: NodeHolder) {
        self.nodeHolder = nodeHolder
    }

    private func processAdjacentNodes(_ node: Int) {
        guard let adjacencyList = graph.adjacencyLists[node]
        else { return }
        
        for nextNode in adjacencyList {
            if let result = graph.visitedNodes[nextNode],
               result == false {
                graph.visitedNodes[nextNode] = true
                nodeHolder.push(nextNode)
            }
        }
    }
    
    private func processFirstNode(_ node: Int) {
        graph.visitedNodes[node] = true
        nodeHolder.push(node)
    }
    
    private func processQueuedNodes() {
        while let currentNode = nodeHolder.pop() {
            processAdjacentNodes(currentNode)
        }
    }
    
    public func search(node: Int, graph: inout Graph) {
        self.graph = graph
        processFirstNode(node)
        processQueuedNodes()
    }
}
