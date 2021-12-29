//
//  DateFormatter.swift
//  TheMovieProject
//
//  Created by gizem.kaya on 28.12.2021.
//

import Foundation

extension DateFormatter {
    static var articleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
