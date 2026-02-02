import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

class RenderContext {
    weak var view: DrawingView?
    var cgContext: CGContext?

    init(view: DrawingView?) {
        self.view = view
        self.cgContext = nil
    }
}
