import Foundation

func task09b() {
    let path = "./09.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    struct Block : CustomStringConvertible {
        var offset = 0
        var length = 0
        var fileId = 0

        var description: String {
            var str = ""
            for _ in 0..<length {
                if fileId == -1 {
                    str += "."
                } else {
                    str += "\(fileId)"
                }
            }
            return str
        }
    }

    func doTask(lines: [String]) {
        var blocks: [Block] = []
        var isFree = false
        var nextId = 0
        var offset = 0
        for char in lines[0] {
            let n = Int(String(char))!
            let id = isFree ? -1 : nextId
            blocks.append(Block(offset: offset, length: n, fileId: id))
            offset += n
            if !isFree {
                nextId += 1
            }
            isFree = !isFree
        }
        var i = blocks.count
        while i > 0 {
            i -= 1
            if blocks[i].fileId == -1 {
                continue
            }
            for j in 0..<i {
                if blocks[j].fileId == -1 && blocks[j].length == blocks[i].length {
                    blocks[j].fileId = blocks[i].fileId
                    blocks[i].fileId = -1
                    break
                } else if blocks[j].fileId == -1 && blocks[j].length > blocks[i].length {
                    let diff = blocks[j].length - blocks[i].length
                    blocks.insert(Block(offset: blocks[j].offset + blocks[i].length, length: diff, fileId: -1), at: j + 1)
                    i += 1
                    blocks[j].fileId = blocks[i].fileId
                    blocks[j].length = blocks[i].length
                    blocks[i].fileId = -1
                    break
                }
            }
        }
        var checksum = 0
        for i in (0..<blocks.count) {
            if blocks[i].fileId == -1 {
                continue
            }
            for j in 0..<blocks[i].length {
                checksum += (j + blocks[i].offset) * blocks[i].fileId
            }
        }
        print(checksum)
    }
}
