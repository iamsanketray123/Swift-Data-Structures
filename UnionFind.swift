final class UnionFind {
    var rank: [Int]
    var parent: [Int]
    var count: Int

    init(_ count: Int) {
        rank = Array(repeating: 1, count: count)
        parent = Array(0..<count)
        self.count = count
    }

    func findParent(_ node: Int) -> Int {
        if parent[node] != node {
            parent[node] = findParent(parent[node])
        }
        return parent[node]
    }

    func union(_ node1: Int, _ node2: Int) {
        let parent1 = findParent(node1)
        let parent2 = findParent(node2)

        if parent1 == parent2 {
            return
        }

        if rank[parent1] > rank[parent2] {
            parent[parent2] = parent1
        } else if rank[parent1] < rank[parent2] {
            parent[parent1] = parent2
        } else {
            parent[parent1] = parent2
            rank[parent2] += 1
        }

        count -= 1
    }
}
