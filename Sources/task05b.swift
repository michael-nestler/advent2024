import Foundation

func task05b() {
    let path = "./05.txt"
    let precedencePattern = /^(\d+)\|(\d+)$/
    let updatePattern = /^\d+(?:,\d+)*$/
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }
    

    func doTask(lines: [String]) {
        var precedences: [Precedence] = []
        var updates: [Update] = []
        for line in lines {
            if let match = line.wholeMatch(of: precedencePattern) {
                precedences.append(Precedence(first: Int(match.1)!, then: Int(match.2)!))
            } else if let match = line.wholeMatch(of: updatePattern) {
                let pages = match.0.split(separator: ",").map { Int($0)! }
                updates.append(Update(pages: pages))
            }
        }
        var sum = 0
        for update in updates {
            var alreadyPrinted: [Int] = []
            var pagesToPrint = Array(update.pages)
            while pagesToPrint.count > 0 {
                let nextPage = findNext(pagesToPrint: pagesToPrint, precedences: precedences)
                pagesToPrint.remove(at: pagesToPrint.firstIndex(of: nextPage)!)
                alreadyPrinted.append(nextPage)
            }
            for i in 0..<(alreadyPrinted.count) {
                if alreadyPrinted[i] != update.pages[i] {
                    sum += alreadyPrinted[alreadyPrinted.count / 2]
                    print("Changed \(update.pages) to \(alreadyPrinted)")
                    break
                }
            }
        }
        print(sum)
    }

    func findNext(pagesToPrint: [Int],  precedences: [Precedence]) -> Int {
        for precedence in precedences {
            if precedence.then == pagesToPrint[0] && pagesToPrint.contains(precedence.first) {
                var rest = Array(pagesToPrint)
                rest.remove(at: rest.firstIndex(of: precedence.first)!)
                rest.insert(precedence.first, at: 0)
                return findNext(pagesToPrint: rest, precedences: precedences)
            }
        }
        return pagesToPrint[0]
    }

    struct Precedence {
        let first: Int
        let then: Int
    }

    struct Update {
        let pages: [Int]
    }
}
