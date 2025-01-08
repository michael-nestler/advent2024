import Foundation

func task04a() {
    let path = "./04.txt"
    do {
        let text = try NSString(contentsOfFile: path, encoding: 4)
        let lines = text.components(separatedBy: NSCharacterSet.newlines)
            .map { $0.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        doTask(lines: lines)
    } catch {
        print("Error: file not found - \(path) - \(error)")
    }
    

    func doTask(lines: [String]) {
        var matches = 0
        let data = lines.map { Array($0) }
        for i in 0..<lines.count {
            for j in 0..<lines[i].count {
                matches = matches + countMatches(data: data, x: j, y: i)
            }
        }
        print(matches)
    }

    func countMatches(data: [[Character]], x: Int, y: Int) -> Int {
        return 
            (left(data: data, x: x, y: y) ? 1 : 0)
          + (right(data: data, x: x, y: y) ? 1 : 0)
          + (up(data: data, x: x, y: y) ? 1 : 0)
          + (down(data: data, x: x, y: y) ? 1 : 0)
          + (diagLeft(data: data, x: x, y: y) ? 1 : 0)
          + (diagRight(data: data, x: x, y: y) ? 1 : 0)
          + (revDiagLeft(data: data, x: x, y: y) ? 1 : 0)
          + (revDiagRight(data: data, x: x, y: y) ? 1 : 0)

    }

    func left(data: [[Character]], x: Int, y: Int) -> Bool {
        if x - 3 < 0 {
            return false
        }
        return data[y][x] == "X" && data[y][x - 1] == "M" && data[y][x - 2] == "A" && data[y][x - 3] == "S"
    }

    func right(data: [[Character]], x: Int, y: Int) -> Bool {
        if x + 3 >= data[y].count {
            return false
        }
        return data[y][x] == "X" && data[y][x + 1] == "M" && data[y][x + 2] == "A" && data[y][x + 3] == "S"
    }

    func up(data: [[Character]], x: Int, y: Int) -> Bool {
        if y - 3 < 0 {
            return false
        }
        return data[y][x] == "X" && data[y - 1][x] == "M" && data[y - 2][x] == "A" && data[y - 3][x] == "S"
    }

    func down(data: [[Character]], x: Int, y: Int) -> Bool {
        if y + 3 >= data.count {
            return false
        }
        return data[y][x] == "X" && data[y + 1][x] == "M" && data[y + 2][x] == "A" && data[y + 3][x] == "S"
    }

    func diagLeft(data: [[Character]], x: Int, y: Int) -> Bool {
        if x - 3 < 0 || y + 3 >= data.count {
            return false
        }
        return data[y][x] == "X" && data[y + 1][x - 1] == "M" && data[y + 2][x - 2] == "A" && data[y + 3][x - 3] == "S"
    }

    func diagRight(data: [[Character]], x: Int, y: Int) -> Bool {
        if x + 3 >= data[y].count || y + 3 >= data.count {
            return false
        }
        return data[y][x] == "X" && data[y + 1][x + 1] == "M" && data[y + 2][x + 2] == "A" && data[y + 3][x + 3] == "S"
    }

    func revDiagLeft(data: [[Character]], x: Int, y: Int) -> Bool {
        if x - 3 < 0 || y - 3 < 0 {
            return false
        }
        return data[y][x] == "X" && data[y - 1][x - 1] == "M" && data[y - 2][x - 2] == "A" && data[y - 3][x - 3] == "S"
    }

    func revDiagRight(data: [[Character]], x: Int, y: Int) -> Bool {
        if x + 3 >= data[y].count || y - 3 < 0 {
            return false
        }
        return data[y][x] == "X" && data[y - 1][x + 1] == "M" && data[y - 2][x + 2] == "A" && data[y - 3][x + 3] == "S"
    }
}
