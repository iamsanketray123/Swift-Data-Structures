/// An optimized Trie (Prefix Tree) data structure in Swift
class Trie {
    /// Internal TrieNode class with compact storage
    private class TrieNode {
        /// Use a dictionary for efficient character-to-node mapping
        /// Nullable to save memory when no children exist
        private var children: [Character: TrieNode]?
        
        /// Flag to mark the end of a word
        private var isEndOfWord: Bool = false
        
        /// Lazy initialization of children dictionary
        private func ensureChildrenInitialized() {
            if children == nil {
                children = [:]
            }
        }
        
        /// Add a child node for a specific character
        func addChild(_ char: Character) -> TrieNode {
            ensureChildrenInitialized()
            if let existingChild = children?[char] {
                return existingChild
            }
            let newNode = TrieNode()
            children?[char] = newNode
            return newNode
        }
        
        /// Get child node for a specific character
        func getChild(_ char: Character) -> TrieNode? {
            return children?[char]
        }
        
        /// Mark this node as the end of a word
        func markAsWord() {
            isEndOfWord = true
        }
        
        /// Check if this node represents the end of a word
        func isWord() -> Bool {
            return isEndOfWord
        }
        
        /// Check if the node has any children
        func hasChildren() -> Bool {
            return children != nil && !(children?.isEmpty ?? true)
        }
        
        /// Remove all children to free up memory
        func removeChildren() {
            children = nil
        }
    }
    
    /// Root node of the Trie
    private let root: TrieNode
    
    /// Total number of words in the Trie
    private(set) var count: Int = 0
    
    /// Initialize an empty Trie
    init() {
        root = TrieNode()
    }
    
    /// Insert a word into the Trie
    /// Time Complexity: O(m), where m is the length of the word
    /// Space Complexity: O(m) in the worst case
    func insert(_ word: String) {
        guard !word.isEmpty else { return }
        
        var currentNode = root
        for char in word.lowercased() {
            currentNode = currentNode.addChild(char)
        }
        
        // Only increment count if this is a new word
        if !currentNode.isWord() {
            currentNode.markAsWord()
            count += 1
        }
    }
    
    /// Search for a complete word in the Trie
    /// Time Complexity: O(m), where m is the length of the word
    /// Space Complexity: O(1)
    func search(_ word: String) -> Bool {
        guard !word.isEmpty else { return false }
        
        guard let lastNode = traverse(word) else { return false }
        return lastNode.isWord()
    }
    
    /// Check if any words start with the given prefix
    /// Time Complexity: O(m), where m is the length of the prefix
    /// Space Complexity: O(1)
    func startsWith(_ prefix: String) -> Bool {
        return traverse(prefix) != nil
    }
    
    /// Helper method to traverse to the last node of a word/prefix
    private func traverse(_ str: String) -> TrieNode? {
        var currentNode = root
        for char in str.lowercased() {
            guard let nextNode = currentNode.getChild(char) else {
                return nil
            }
            currentNode = nextNode
        }
        return currentNode
    }
    
    /// Delete a word from the Trie
    /// Time Complexity: O(m), where m is the length of the word
    /// Space Complexity: O(m) for recursion stack
    func delete(_ word: String) {
        guard !word.isEmpty else { return }
        
        func deleteHelper(_ node: TrieNode, _ word: String, _ index: Int) -> Bool {
            guard index < word.count else {
                // Reached end of word
                if !node.isWord() { return false }
                node.removeChildren() // Clear any children
                return true
            }
            
            let char = Array(word)[index]
            guard let childNode = node.getChild(char) else {
                return false
            }
            
            // Recursively delete
            let shouldDeleteCurrentNode = deleteHelper(childNode, word, index + 1)
            
            // If no children and not a word, remove the node
            if shouldDeleteCurrentNode && !childNode.hasChildren() {
                node.removeChildren()
                count -= 1
                return true
            }
            
            return false
        }
        
        _ = deleteHelper(root, word.lowercased(), 0)
    }
}

// Example usage
extension Trie {
    /// Retrieve all words with a given prefix
    /// Time Complexity: O(n), where n is the total number of characters in all matching words
    /// Space Complexity: O(n) to store the result
    func wordsWithPrefix(_ prefix: String) -> [String] {
        guard let prefixNode = traverse(prefix) else { return [] }
        
        var result: [String] = []
        
        func dfs(_ node: TrieNode, _ currentWord: String) {
            if node.isWord() {
                result.append(currentWord)
            }
            
            // Explore all children
            guard let children = node.children else { return }
            for (char, childNode) in children {
                dfs(childNode, currentWord + String(char))
            }
        }
        
        dfs(prefixNode, prefix)
        return result
    }
}

// Demonstrate Trie operations
func demonstrateTrie() {
    let trie = Trie()
    
    // Insert words
    trie.insert("apple")
    trie.insert("app")
    trie.insert("apricot")
    
    // Search operations
    print("Search 'apple': \(trie.search("apple"))") // true
    print("Search 'app': \(trie.search("app"))") // true
    print("Search 'banana': \(trie.search("banana"))") // false
    
    // Prefix search
    print("Starts with 'app': \(trie.startsWith("app"))") // true
    print("Starts with 'ban': \(trie.startsWith("ban"))") // false
    
    // Words with prefix
    print("Words with prefix 'app': \(trie.wordsWithPrefix("app"))") // ["app", "apple", "apricot"]
    
    // Delete a word
    trie.delete("apple")
    print("Search 'apple' after delete: \(trie.search("apple"))") // false
    print("Search 'app' after delete: \(trie.search("app"))") // true
}
