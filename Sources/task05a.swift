import Foundation

func task05a() {
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
            var valid = true
            for page in update.pages {
                if !valid {
                    break
                }
                for precedence in precedences {
                    if precedence.then == page && !alreadyPrinted.contains(precedence.first) && update.pages.contains(precedence.first) {
                        valid = false
                        break
                    } 
                }
                alreadyPrinted.append(page)
            }
            if valid {
                sum += update.pages[update.pages.count / 2]
            }
        }
        print(sum)
    }

    struct Precedence {
        let first: Int
        let then: Int
    }

    struct Update {
        let pages: [Int]
    }
}
