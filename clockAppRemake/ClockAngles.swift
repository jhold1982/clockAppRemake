//
//  ClockAngles.swift
//  clockAppRemake
//
//  Created by Justin Hold on 12/30/24.
//

import Foundation
import SwiftUI

struct ClockAngles {
	var hour: Angle
	var minute: Angle
	var second: Angle
	
	init(for date: Date) {
		let components = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
		
		let hourComponent = components.hour ?? 0
		let minuteComponent = Double(components.minute ?? 0)
		let secondComponent = Double(components.second ?? 0)
		let nanoComponent = Double(components.nanosecond ?? 0)
		
		hour = .degrees(30 * (Double(hourComponent % 12) + minuteComponent / 60) + 180)
		minute = .degrees(6 * (minuteComponent + secondComponent / 60) + 180)
		second = .degrees(6 * (secondComponent + nanoComponent / 1_000_000_000) + 180)
		
		if hour.radians == .pi { hour = .radians(3.14158) }
		if minute.radians == .pi { minute = .radians(3.14158) }
		if second.radians == .pi { second = .radians(3.14158) }
	}
}

