//
//  File.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 13.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import Foundation

extension Sequence where Iterator.Element == NSAttributedString {
    func joined(with separator: NSAttributedString) -> NSAttributedString {
        return self.reduce(NSMutableAttributedString()) {
            (r, e) in
            if r.length > 0 {
                r.append(separator)
            }
            r.append(e)
            return r
        }
    }
    func joined(with separator: String = "") -> NSAttributedString {
        return self.joined(with: NSAttributedString(string: separator))
    }
}
