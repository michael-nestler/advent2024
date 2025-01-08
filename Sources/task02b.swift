import Foundation

func task02b() {
    let path = "./02.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    func doTask(lines: [String]) {
        let reports = lines.map { $0.split(separator: " ").map { Int($0)! }}
        let safeReports = reports.filter { isSafe(report: $0) }
        let unsafeReports = reports.filter { !isSafe(report: $0) }
        let salvagableReports = unsafeReports.filter { isSalvagable(report: $0) }
        print(safeReports.count + salvagableReports.count)
    }

    func isSafe(report: [Int]) -> Bool {
        let allAscending = zip(report, report.dropFirst(1)).map { tuple -> Bool in 
            let (a, b) = tuple
            return a < b 
        }.allSatisfy { $0 }
        let allDescending = zip(report, report.dropFirst(1)).map { tuple -> Bool in 
            let (a, b) = tuple
            return a > b 
        }.allSatisfy { $0 }
        let allPaddedSafely = zip(report, report.dropFirst(1)).map { tuple -> Bool in 
            let (a, b) = tuple
            let diff = abs(a - b)
            return diff >= 1 && diff <= 3
        }.allSatisfy { $0 }
        return allPaddedSafely && (allAscending || allDescending)
    }

    func isSalvagable(report: [Int]) -> Bool {
        var copy: [Int] = []
        for i in 0..<report.count {
            for j in 0..<report.count {
                if i != j {
                    copy.append(report[j])
                }
            }
            if isSafe(report: copy) {
                return true
            }
            copy.removeAll(keepingCapacity: true)
        }
        return false
    }
}
