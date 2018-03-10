//
//  DockProgressBar.swift
//  WWDC
//
//  Created by David Roberts on 24/07/2015.
//  Copyright © 2015 Dave Roberts. All rights reserved.
//

import Foundation
import Cocoa

class DockProgressBar: NSProgressIndicator {
    
    public enum Style: Int {
        case noProgress = 0
        case indeterminate = 0x1
        case normal = 0x2
        case error = 0x4
        case paused = 0x8
    }

    private var _barStyle = Style.normal
    
    convenience init(frame frameRect: NSRect, style: Int) {
        self.init(frame: frameRect)
        self._barStyle = Style(rawValue: style)!
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.style = NSProgressIndicator.Style.bar
        self.isIndeterminate = false
        self.isBezeled = false
        self.minValue = 0
        self.maxValue = 1
        self.isHidden = false
        self.doubleValue = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        
        // Outline
        let rect = self.bounds.insetBy(dx: 1.0, dy: 1.0)
        let radius = rect.size.height / 2
        let bezierPath = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
        bezierPath.lineWidth = 2.0
        NSColor.gray.set()
        bezierPath.stroke()
        
        // inside
        let insideRect = rect.insetBy(dx: 2.0, dy: 2.0)
        let insideRadius = insideRect.size.height / 2
        let insideBezierpath = NSBezierPath(roundedRect: insideRect, xRadius: insideRadius, yRadius: insideRadius)
        insideBezierpath.lineWidth = 1.0
        insideBezierpath.addClip()
        let widthOfProgress = floor(CGFloat(insideRect.size.width) * (CGFloat(self.doubleValue) / CGFloat(self.maxValue)))
        var rectToDraw = insideRect
        rectToDraw.size.width = widthOfProgress
        
        switch _barStyle {
        case .error:
            NSColor.red.set()
        case .indeterminate, .normal:
            NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0).set()
        case .noProgress:
            NSColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 0.0).set()
        case .paused:
            NSColor.yellow.set()
        }
        
        rectToDraw.fill()
    }
    
    private func addProgress() {
        if NSApp.dockTile.contentView == nil {
            let imageView = NSImageView()
            imageView.image = NSApplication.shared.applicationIconImage
            NSApp.dockTile.contentView = imageView
            imageView.addSubview(self)
        }
    }
    
    func updateProgress(progress: Double) {
        addProgress()
        self.isHidden = false
        self.doubleValue = progress
        if self.doubleValue > 0.99 {
            self.isHidden = true
        }
        NSApp.dockTile.display()
    }
    
    func setStyle(style: Int) {
        self._barStyle = Style(rawValue: style)!
        if self._barStyle == Style.noProgress {
            hideProgressBar()
        } else {
            self.isHidden = false
        }
        NSApp.dockTile.display()
    }
    
    func hideProgressBar() {
        self.isHidden = true
        NSApp.dockTile.display()
    }
    
    func removeProgress() {
        self.doubleValue = 0
        NSApp.dockTile.contentView = nil
        NSApp.dockTile.display()
    }
    
}
