import Foundation

func task09a() {
    let path = "./09.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    func doTask(lines: [String]) {
        var blocks: [Int] = []
        var isFree = false
        var nextId = 0
        for char in lines[0] {
            let n = Int(String(char))!
            for _ in 0..<n {
                if isFree {
                    blocks.append(-1)
                } else {
                    blocks.append(nextId)
                }
            }
            if !isFree {
                nextId += 1
            }
            isFree = !isFree
        }
        var leftOffset = 0
        for i in (0..<blocks.count).reversed() {
            while blocks[leftOffset] != -1 && leftOffset < i {
                leftOffset += 1
            }
            if i <= leftOffset {
                break
            }
            if blocks[i] == -1 {
                continue
            }
            blocks[leftOffset] = blocks[i]
            blocks[i] = -1
        }
        var checksum = 0
        for i in (0..<blocks.count) {
            if blocks[i] == -1 {
                break
            }
            checksum += blocks[i] * i
        }
        print(checksum)
    }
}
