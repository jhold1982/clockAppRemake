//
//  ContentView.swift
//  clockAppRemake
//
//  Created by Justin Hold on 12/30/24.
//

import SwiftUI

struct ContentView: View {
	
	// MARK: - Properties
	
	
	
	// MARK: - View Body
    var body: some View {
        
		TimelineView(.animation) { timeline in
			Canvas {
				context,
				size in
				let clock = ClockAngles(for: timeline.date)
				
				let drawRect = CGRect(origin: .zero, size: size)
				let radius = min(size.width, size.height) / 2
				
				let borderThickness = radius / 25
				let innerBlackRingSize = radius / 6
				let centerSize = radius / 40
				
				let hourHandLength = radius / 2.5
				let minuteHandLength = radius / 1.5
				
				let secondHandLength = radius / 1.1
				let secondHandWidth = radius / 25
				
				context.stroke(
					Circle().inset(by: borderThickness / 2).path(in: drawRect),
					with: .color(.primary),
					lineWidth: borderThickness
				)
				
				context.translateBy(x: drawRect.midX, y: drawRect.midY)
				
				drawHours(in: context, radius: radius)
				
				drawHand(in: context, radius: radius, length: minuteHandLength, angle: clock.minute)
				drawHand(in: context, radius: radius, length: hourHandLength, angle: clock.hour)
				
				let rect = CGRect(
					x: -innerBlackRingSize / 2,
					y: -innerBlackRingSize / 2,
					width: innerBlackRingSize,
					height: innerBlackRingSize
				)
				
				context.stroke(Circle().path(in: rect), with: .color(.primary), lineWidth: centerSize)
				
				let secondLine = Capsule().offset(x: 0, y: -radius / 6).rotation(clock.second, anchor: .top).path(in: CGRect(x: -secondHandWidth / 2, y: 0, width: secondHandWidth, height: secondHandLength))
				
				context.fill(secondLine, with: .color(.orange))
				
				let centerPiece = Circle().path(in: rect.insetBy(dx: centerSize, dy: centerSize))
				
				context.fill(centerPiece, with: .color(.white))
				
				context.stroke(centerPiece, with: .color(.orange), lineWidth: centerSize)
			}
		}
		.frame(width: 300, height: 300)
    }
	
	// MARK: - Functions
	/// Draws the clock hand for hour, minutes, and seconds
	/// - Parameters:
	///   - context: The Graphics Context
	///   - radius: Double value for Radius
	///   - lenght: Double value for Length
	///   - angle: Angle value for Angle
	func drawHand(in context: GraphicsContext, radius: Double, length: Double, angle: Angle) {
	
	let width = radius / 30
	
	let stalk = Rectangle().rotation(
		angle,
		anchor: .top
	).path(
		in: CGRect(
			x: -width / 2,
			y: 0,
			width: width,
			height: length
		)
	)
	
	context.fill(
		stalk,
		with: .color(.primary)
	)
	
	let hand = Capsule().offset(
		x: 0,
		y: radius / 5
	).rotation(
		angle,
		anchor: .top
	).path(
		in: CGRect(
			x: -width,
			y: 0,
			width: width * 2,
			height: length
		)
	)
	
	context.fill(
		hand,
		with: .color(.primary)
	)
}
	
	/// Draws the numerical hours on the watch face
	/// - Parameters:
	///   - context: Graphics Context
	///   - radius: Size of numbers in Double
	func drawHours(in context: GraphicsContext, radius: Double) {
		
		let textSpace = CGSize(width: 200, height: 200)
		let textSize = radius / 4
		let textOffset = radius * 0.75
		
		for i in 1...12 {
			
			var contextCopy = context
			let text = Text(String(i)).font(.system(size: textSize)).bold()
			let resolvedText = contextCopy.resolve(text)
			
			let textSize = resolvedText.measure(in: textSpace)
			contextCopy.translateBy(x: -textSize.width / 2, y: -textSize.height / 2)
			
			let point = CGPoint(
				x: 0,
				y: -textOffset
			).applying(CGAffineTransform(rotationAngle: Double(i) * .pi / 6))
			
			contextCopy.draw(resolvedText, in: CGRect(origin: point, size: textSpace))
		}
	}
}

#Preview {
    ContentView()
}
