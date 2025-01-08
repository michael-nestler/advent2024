import Foundation

func task06a() {
    let path = "./06.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }

    enum State {
        case obstacle
        case empty
        case travelled
        case watcher
    }
    
    enum Direction {
        case left, right, up, down
    }

    func doTask(lines: [String]) {
        var map: [[State]] = []
        var direction: Direction = .up
        var posRow = 0
        var posCol = 0
        for (rowIndex, line) in lines.enumerated() {
            var row: [State] = []
            for (colIndex, character) in line.enumerated() {
                var state: State = .empty
                switch character {
                    case ".": state = .empty
                    case "#": state = .obstacle
                    case "^": 
                      state = .watcher
                      posRow = rowIndex
                      posCol = colIndex
                    default: print("Invalid map character \(character)")
                }
                row.append(state)
            }
            map.append(row)
        }
        print("Starting simulation")
        while true {
            let nextRow = direction == .up ? posRow - 1 : direction == .down ? posRow + 1 : posRow
            let nextCol = direction == .left ? posCol - 1 : direction == .right ? posCol + 1 : posCol
            if nextRow < 0 || nextCol < 0 || nextRow >= lines.count || nextCol >= lines[nextRow].count {
                map[posRow][posCol] = .travelled
                break
            }
            if map[nextRow][nextCol] == .obstacle {
                switch (direction) {
                    case .left: direction = .up
                    case .up: direction = .right
                    case .right: direction = .down
                    case .down: direction = .left
                }
                continue
            }
            map[posRow][posCol] = .travelled
            map[nextRow][nextCol] = .watcher
            posRow = nextRow
            posCol = nextCol
        }
        let travelled = map.flatMap { $0 }.filter { $0 == .travelled }.count
        print(travelled)
    }
}
