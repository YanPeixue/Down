//
//  AttributedStringVisitor.swift
//  Down
//
//  Created by yanpeixue on 2024/11/7.
//

import Foundation

class MyGreetingVisitor: AttributedStringVisitor {
    
    
    
    override func visit(strong node: Strong) -> NSMutableAttributedString {
        let result = super.visit(strong: node)
        result.addAttributes([.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)], range: NSRange(location: 0, length: result.length))
        return result
    }

    override func visit(customInline node: CustomInline) -> NSMutableAttributedString {
        let result = super.visit(customInline: node)
        return result
    }
    
    override func visit(emphasis node: Emphasis) -> NSMutableAttributedString {
        let result = super.visit(emphasis: node)
        result.addAttributes([.foregroundColor: UIColor.hex_color(hex: "#C3ABEA"), .font: UIFont.italicSystemFont(ofSize: 14)], range: NSRange(location: 0, length: result.length))
        return result
    }
    
}

public extension UIColor {
    
    class func hex_color(hex hexStr: String, alpha: CGFloat = 1.0) -> UIColor {
        var cstr = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if cstr.count < 6 {
            return UIColor.clear
        }
        if cstr.hasPrefix("0X") {
            cstr = cstr.subString(from: 2)
        } else if cstr.hasPrefix("0x") {
            cstr = cstr.subString(from: 2)
        } else if cstr.hasPrefix("#") {
            cstr = cstr.subString(from: 1)
        }
        if cstr.count != 6 {
            return UIColor.clear
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        let rStr = cstr.subString(range)
        range.location = 2
        let gStr = cstr.subString(range)
        range.location = 4
        let bStr = cstr.subString(range)
        var r: Int64 = 0x0;
        var g: Int64 = 0x0;
        var b: Int64 = 0x0;
        Scanner.init(string: rStr).scanHexInt64(&r)
        Scanner.init(string: gStr).scanHexInt64(&g)
        Scanner.init(string: bStr).scanHexInt64(&b)
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha);
    }
}

extension String {
    func subString(_ range: NSRange) -> String {
        
        let start = range.location
        let length = range.length
        if (start + length) > self.count {
            return ""
        }
        return String(self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: start + length)])
    }
    
    func subString(from index: Int) -> String {
        if index >= self.count || index < 0 {
            return ""
        }
        return String(self[self.index(self.startIndex, offsetBy: index)..<self.endIndex])
    }
    
}


