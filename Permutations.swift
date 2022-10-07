    func permute(_ arr: inout [Character], _ index: Int, _ res: inout Set<String>) {

        if index >= arr.count { 
            let strArr = arr.map{String($0)}
            let str = strArr.joined(separator: "")
            res.insert(str)
            return
        }

        for j in index..<arr.count {
            arr.swapAt(index, j)
            permute(&arr, index+1, &res)
            arr.swapAt(index, j)
        }
    }
