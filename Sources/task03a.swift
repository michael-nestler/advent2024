import Foundation

func task03a() {
    let path = "./03.txt"
    let mulDefs = /mul\((\d+),(\d+)\)/
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        doTask(text: text as String)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }
    

    func doTask(text: String) {
        var rest = text[text.startIndex..<text.endIndex]
        var sum = 0
        while true {
            let result = extractMatch(input: rest)
            if let ((a, b), r) = result {
                rest = r
                sum = sum + a * b
            } else {
                break
            }
        }
        print(sum)
    }

    func extractMatch(input: Substring) -> ((Int, Int), Substring)? {
        if let match = input.firstMatch(of: mulDefs) {
            let rest = input.suffix(from: match.range.upperBound)
            return ((Int(match.1)!, Int(match.2)!), rest)
        }
        return nil
    }
}
