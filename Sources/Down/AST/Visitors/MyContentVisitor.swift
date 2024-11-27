//
//  MyContentVisitor.swift
//  Pods
//
//  Created by yanpeixue on 2024/11/7.
//

class MyContentVisitor: MyGreetingVisitor {
    
    override func visit(strong node: Strong) -> NSMutableAttributedString {
        let result = super.visit(strong: node)
//        result.append(NSAttributedString(string: "\n"))
        return result
    }
    
    override func visit(emphasis node: Emphasis) -> NSMutableAttributedString {
        let result = super.visit(emphasis: node)
        result.addAttributes([.foregroundColor: UIColor.hex_color(hex: "#C3ABEA"), .font: UIFont.italicSystemFont(ofSize: 14)], range: NSRange(location: 0, length: result.length))
        return result
        
    }
    
    override func visit(paragraph node: Paragraph) -> NSMutableAttributedString {
        let result = super.visit(paragraph: node)
        return result
    }
    
    override func visit(blockQuote node: BlockQuote) -> NSMutableAttributedString {
        let result = super.visit(blockQuote: node)
        return result
    }

    override func visit(htmlBlock node: HtmlBlock) -> NSMutableAttributedString {
        let result = super.visit(htmlBlock: node)
        return result
    }
    
    override func visit(image node: Image) -> NSMutableAttributedString {
        let result = super.visit(image: node)
        result.append(NSAttributedString(string: "\n"))
        return result
    }
    
    override func visit(lineBreak node: LineBreak) -> NSMutableAttributedString {
        let result = super.visit(lineBreak: node)
        return result
    }
    
    override func visit(softBreak node: SoftBreak) -> NSMutableAttributedString {
        let result = super.visit(softBreak: node)
        return result
    }
    
    override func visit(text node: Text) -> NSMutableAttributedString {
        let result = super.visit(text: node)
        result.trimWhitespaces()
        if result.string.trimmingCharacters(in: .whitespaces).count > 0 {
            result.append(NSAttributedString(string: "\n"))
        }
        return result
    }
    
}

extension NSMutableAttributedString {
    func trimWhitespaces() {
        // 去除前导空格
        while let firstCharacter = string.first, firstCharacter.isWhitespace {
            deleteCharacters(in: NSRange(location: 0, length: 1))
        }
        
        // 去除尾部空格
        while let lastCharacter = string.last, lastCharacter.isWhitespace {
            deleteCharacters(in: NSRange(location: length - 1, length: 1))
        }
    }
}
