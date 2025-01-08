import Foundation

func task04b() {
    let path = "./04.txt"
    let patterns: [[[Character]]] = [
        [
            ["M", ".", "S"],
            [".", "A", "."],
            ["M", ".", "S"],
        ],
        
        [
            ["S", ".", "S"],
            [".", "A", "."],
            ["M", ".", "M"],
        ],
        [
            ["M", ".", "M"],
            [".", "A", "."],
            ["S", ".", "S"],
        ],
        
        [
            ["S", ".", "M"],
            [".", "A", "."],
            ["S", ".", "M"],
        ],
    ]
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
        for i in 0..<(lines.count - 2) {
            for j in 0..<(lines[i].count - 2) {
                for pattern in patterns {
                    if 
                        data[i][j] == pattern[0][0] &&
                        data[i + 2][j] == pattern[2][0] &&
                        data[i + 1][j + 1] == pattern[1][1] &&
                        data[i][j + 2] == pattern[0][2] &&
                        data[i + 2][j + 2] == pattern[2][2] {
                            matches = matches + 1
                        }
                }
            }
        }
        print(matches)
    }
}
