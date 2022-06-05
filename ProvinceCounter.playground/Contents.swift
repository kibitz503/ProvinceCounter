import Foundation

//
//class Graph {
//    private var nodeCount = 0
//    private var adjacencyLists = [Int : [Int]]()
//    private var visitedNodes = [Int : Bool]()
//
//    init(nodeCount: Int) {
//        self.nodeCount = nodeCount
//
//        for i in 0...nodeCount {
//            visitedNodes[i] = false
//        }
//    }
//
//    func addEdge(startingPoint: Int, endingPoint: Int) {
//        if var list = adjacencyLists[startingPoint] {
//            list.append(endingPoint)
//            adjacencyLists[startingPoint] = list
//        } else {
//            adjacencyLists[startingPoint] = [endingPoint]
//        }
//    }
//
//    func breadthFirstSearch(node: Int) {
//        var queue = [Int]()
//        visitedNodes[node] = true
////        print("Initial Queue \(node)")
//        queue.append(node)
//
//        while !queue.isEmpty {
//
//            //grab the first node off of the queue and process it
//            let currentNode = queue.first!
////            print("processing \(currentNode)")
//            queue.remove(at: 0)
//
//            for nextNode in adjacencyLists[currentNode]! {
//
//                if visitedNodes[nextNode]! == false {
//                    visitedNodes[nextNode] = true
////                    print("Queueing \(nextNode)")
//                    queue.append(nextNode)
//                }
//
//            }
//        }
//    }
//}
//
////let graph = Graph(nodeCount: 4)
////
////graph.addEdge(startingPoint: 0, endingPoint: 1)
////graph.addEdge(startingPoint: 0, endingPoint: 2)
////graph.addEdge(startingPoint: 1, endingPoint: 2)
////graph.addEdge(startingPoint: 2, endingPoint: 0)
////graph.addEdge(startingPoint: 2, endingPoint: 3)
////graph.addEdge(startingPoint: 3, endingPoint: 3)
////
////graph.breadthFirstSearch(node: 2)
//
//extension Graph {
//    var hasUnvisitedNodes: Bool {
//        get {
//            nextUnvisitedNode != nil
//        }
//    }
//
//    var nextUnvisitedNode: Int? {
//        get {
//            for i in 0...(nodeCount - 1) {
//                if let node = visitedNodes[i] {
//                    if node == false {
//                        return i
//                    }
//                }
//            }
//            return nil
//        }
//    }
//
//    func runNextNode() {
//        if let node = nextUnvisitedNode {
//            breadthFirstSearch(node: node)
//        }
//    }
//}
////https://leetcode.com/problems/number-of-provinces/submissions/
//class ProvinceCounter {
//    private var provinceCount = 0
//    private var cityList = [[Int]]()
//    private var graph = Graph(nodeCount: 0)
//
//    func cities(cityList: [[Int]]) -> Int {
//        self.cityList = cityList
//
//        setupGraph()
//        runGraph()
//
//        return provinceCount
//    }
//
//    private func setupGraph() {
//        graph = Graph(nodeCount: cityList.count)
//        populateGraph()
//    }
//
//    private func populateGraph() {
//        for (city, cityRoutes) in cityList.enumerated() {
//            for (destination, hasRoute) in cityRoutes.enumerated() {
//                if hasRoute == 1 {
//                    print("Adding startingPoint: \(city) -> endingPoint: \(destination)")
//                    graph.addEdge(startingPoint: city, endingPoint: destination)
//                }
//            }
//        }
//    }
//
//    private func runGraph() {
//        while graph.hasUnvisitedNodes {
//            provinceCount += 1
//            graph.runNextNode()
//        }
//    }
//}
//
////let cityList = [[1,1,0],[1,1,0],[0,0,1]]
//let cityList = [[1,1,0,0,0,0],[1,1,0,0,0,0],[0,0,1,1,0,1],[0,0,1,1,0,0],[0,0,0,0,1,0],[0,0,1,0,0,1]] //3
////let cityList = [[1,1,0,0,0,0],[1,1,0,0,0,0],[0,0,1,1,0,1],[0,0,1,1,0,0],[0,0,0,0,1,1],[0,0,1,0,1,1]] //2
////let cityList = [[1,1,0,0,0,1],[1,1,0,0,0,0],[0,0,1,1,0,1],[0,0,1,1,0,0],[0,0,0,0,1,1],[1,0,1,0,1,1]] //1
//let provinceCounter = ProvinceCounter()
//print(provinceCounter.cities(cityList: cityList))

//https://leetcode.com/problems/number-of-provinces/submissions/
public class ProvinceCounter {
    private let graphBuilder: GraphBuilder
    private let algorithm: Search
    
    init(graphBuilder: GraphBuilder, algorithm: Search) {
        self.graphBuilder = graphBuilder
        self.algorithm = algorithm
    }
    
    func cities(_ cityList: [[Int]]) -> Int {
        var graph = populateGraph(cityList)
        return run(&graph)
    }
    
    private func populateGraph(_ cityList: [[Int]]) -> Graph {
        for (city, cityRoutes) in cityList.enumerated() {
            for (destination, hasRoute) in cityRoutes.enumerated() {
                if hasRoute == 1 {
                    graphBuilder.addEdge(startingPoint: city,
                                         endingPoint: destination)
                }
            }
        }
        return graphBuilder.build()
    }
    
    private func run(_ graph: inout Graph) -> Int {
        var provinceCount = 0
        
        while let nextNode = graph.nextDisconnectedNode {
            provinceCount += 1
            algorithm.search(node: nextNode, graph: &graph)
        }
        
        return provinceCount
    }
}

class Solution {
    func findCircleNum(_ isConnected: [[Int]]) -> Int {
//        let provinceCounter = ProvinceCounter(
//            graphBuilder: GraphBuilderImplementation(),
//            algorithm: RecursiveSearchImplementation())
        
//        let provinceCounter = ProvinceCounter(
//            graphBuilder: GraphBuilderImplementation(),
//            algorithm: SearchImplementation(nodeHolder: Stack()))
        
        let provinceCounter = ProvinceCounter(
            graphBuilder: GraphBuilderImplementation(),
            algorithm: SearchImplementation(nodeHolder: Queue()))
        
        return provinceCounter.cities(isConnected)
    }
}

//let cityList = [[1,1,0],[1,1,0],[0,0,1]] //2
//let cityList = [[1,1,0,0,0,0],[1,1,0,0,0,0],[0,0,1,1,0,1],[0,0,1,1,0,0],[0,0,0,0,1,0],[0,0,1,0,0,1]] //3
let cityList = [[1,1,0,0,0,0],[1,1,0,0,0,0],[0,0,1,1,0,1],[0,0,1,1,0,0],[0,0,0,0,1,1],[0,0,1,0,1,1]] //2
//let cityList = [[1,1,0,0,0,1],[1,1,0,0,0,0],[0,0,1,1,0,1],[0,0,1,1,0,0],[0,0,0,0,1,1],[1,0,1,0,1,1]] //1

print(Solution().findCircleNum(cityList))
