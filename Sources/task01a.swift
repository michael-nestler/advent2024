import Foundation

func task01a() {
    let path = "./01.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    func doTask(lines: [String]) {
        let left = lines.map { extractLeft(line: $0) }.map { Int($0)! }.sorted()
        let right = lines.map { extractRight(line: $0) }.map { Int($0)! }.sorted()
        var sum = 0
        for (l, r) in zip(left, right) {
            sum = sum + abs(l - r)
        }
        print(sum)
    }

    func extractLeft(line: String) -> String {
        let first = line.firstIndex(of: " ")
        if first == nil {
            return line
        } else {
            return String(line[..<first!])
        }
    }

    func extractRight(line: String) -> String {
        let last = line.lastIndex(of: " ")
        if last == nil {
            return line
        } else {
            return String(line[line.index(after: last!)..<line.endIndex])
        }
    }
}
