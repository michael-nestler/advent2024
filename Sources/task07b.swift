import Foundation

func task07b() {
    let path = "./07.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    func doTask(lines: [String]) {
        var sum: Int64 = 0
        for line in lines {
            let parts = line.split(separator: ": ")
            let target = Int64(parts[0])!
            let elements = parts[1].split(separator: " ").map { Int64($0)! }
            let result = isValid(target: target, currentValue: elements[0], elements: elements, index: 1)
            if result {
                sum += target
            }
        }
        print(sum)
    }

    func isValid(target: Int64, currentValue: Int64, elements: [Int64], index: Int) -> Bool {
        if elements.count == index { return currentValue == target }
        let plusResult = currentValue + elements[index]
        let timesResult = currentValue * elements[index]
        let concatResult = Int64("\(currentValue)\(elements[index])")!
        return isValid(target: target, currentValue: plusResult, elements: elements, index: index + 1)
          || isValid(target: target, currentValue: timesResult, elements: elements, index: index + 1)
          || isValid(target: target, currentValue: concatResult, elements: elements, index: index + 1)
    }
}
