import Foundation

func task02a() {
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
        print(safeReports.count)
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
}
