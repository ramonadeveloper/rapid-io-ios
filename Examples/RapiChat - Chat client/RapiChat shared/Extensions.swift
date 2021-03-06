//
//  Extensions.swift
//  RapiChat
//
//  Created by Jan on 28/06/2017.
//  Copyright © 2017 Rapid.io. All rights reserved.
//

import Foundation
import Rapid

extension String {

    func highlight(string: String, textAttributes: [String: Any], highlightedAttributes: [String: Any]) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: self, attributes: textAttributes)
        
        if let range = self.range(of: string), let nsrange = NSRangeFromRange(range) {
            attributedTitle.addAttributes(highlightedAttributes, range: nsrange)
        }
        
        return attributedTitle
    }
    
    private func NSRangeFromRange(_ range: Range<String.Index>) -> NSRange? {
        
        let utf16view = self.utf16
        
        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
        
        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
        
        return NSRange(location: utf16view.distance(from: utf16view.startIndex, to: from), length: utf16view.distance(from: from, to: to))
    }
    
}

extension Rapid {
    
    class func collection(withName name: String) -> RapidCollectionRef {
        assert(Validator.isValid(collectionName: name), "App uses different collection name than it is supposed to. Make sure that you pasted correct identifier to Info.plist key `RapidDemoIdentifier` and that you didn't modify default Rapid collection name.")
        
        return collection(named: name)
    }
}
