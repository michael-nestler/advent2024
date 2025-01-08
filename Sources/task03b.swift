import Foundation

func task03b() {
    let path = "./03.txt"
    let mulDefs = /(?:do\(\))|(?:don't\(\))|(?:mul\((\d+),(\d+)\))/
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        doTask(text: text as String)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }
    

    func doTask(text: String) {
        var rest = text[text.startIndex..<text.endIndex]
        var sum = 0
        var flag = true
        while true {
            let result = extractMatch(input: rest)
            if let (nums, f, r) = result {
                rest = r
                if f != nil {
                    flag = f!
                }
                if flag, let (a, b) = nums {
                    sum = sum + a * b
                }
            } else {
                break
            }
        }
        print(sum)
    }

    func extractMatch(input: Substring) -> ((Int, Int)?, Bool?, Substring)? {
        if let match = input.firstMatch(of: mulDefs) {
            let rest = input.suffix(from: match.range.upperBound)
            let isDo = match.0 == "do()"
            let isDont = match.0 == "don't()"
            let flag = isDo ? true : isDont ? false : nil 
            let nums = !isDo && !isDont ? (Int(match.1!)!, Int(match.2!)!) : nil
            return (nums, flag, rest)
        }
        return nil
    }
}
