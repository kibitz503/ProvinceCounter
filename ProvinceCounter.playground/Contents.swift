import Foundation

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
