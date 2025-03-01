class UnionFind {
    
    // MARK: - Variables
    var parent: [Int]
    var rank: [Int]
    var count: Int
    
    // MARK: - Initialisation Method
    init(_ count: Int) {
        parent = Array(repeating: -1, count: count)
        rank = Array(repeating: 1, count: count)
        self.count = count
    }
    
    // MARK: - Helper Methods
    func findParent(_ node: Int) -> Int {

        if parent[node] == -1 {
            return node
        }
        
        // Path Compression
        parent[node] = findParent(parent[node])
      
        return parent[node]
    }
    
    func union(_ node1: Int, _ node2: Int) {
        
        let parent1 = findParent(node1)
        let parent2 = findParent(node2)
        
        // If both have same parents, there is are part of one component already and hence there is no need for union
        if parent1 == parent2 {
            return
        }
        
        // Union by rank
        if rank[parent1] > rank[parent2] {
            parent[parent2] = parent1
        } else if rank[parent1] < rank[parent2] {
            parent[parent1] = parent2
        } else {
            parent[parent1] = parent2
            rank[parent2] += 1
        }
        
        // Reduce count by 1 when we merge two components
        count -= 1
    }
}
