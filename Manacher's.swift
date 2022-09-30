// Reference: http://web.archive.org/web/20181208031518/https://articles.leetcode.com/longest-palindromic-substring-part-ii/

func longestPalindrome(_ s: String) -> String {
        // For example, if s = "abba", then t = "$#a#b#b#a#@"
        // the # are interleaved to avoid even/odd-length palindromes uniformly
        // $ and @ are prepended and appended to each end to avoid bounds checking
        var tArr: [String] = []
        tArr.append("$")
        for v in s {
            tArr.append("#")
            tArr.append(String(v))
        }
        tArr.append("#")
        tArr.append("@")
       
        var R = 1
        var center = 1
        let arrCount = tArr.count - 1
        
        // p will store the length of max substring
        var p: [Int] = Array(repeating: 0, count: tArr.count)
        
        for i in 1..<arrCount {
            // Step 1. Calculate Mirror Position
            let mirror = 2*center - i
            
            // Step 2. Test Does i Lies with in R
            if R > i {
                // If yes it does Copy using mirror
                p[i] = min(R-i, p[mirror])    
            }
           
            //Step 3. Expansion Step
            let temp = i + p[i] + 1

            while(tArr[i+(p[i] + 1)] == tArr[i-(p[i] + 1)]) {
                // increase p[i] until we can expand
                p[i] += 1
            }
            
            //Step 4. Test: i has moved beyond R?
            if (p[i] + i > R) {
                // update R & Center
                center = i
                R = p[i] + i
            }
        }
            
        var centerIndex = 0;
        var maxP = 0
        for i in 0..<arrCount {
          if p[i] > maxP {
            maxP = p[i]
            centerIndex = i
          }
        }
       
        let start = (centerIndex - 1 - maxP)/2
        let result = s[s.index(s.startIndex, offsetBy: start)..<s.index(s.startIndex, offsetBy:start+maxP)]

        return String(result)
    }
