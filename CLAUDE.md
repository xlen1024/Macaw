# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Macaw is a deprecated Swift vector graphics library with SVG support for iOS and macOS. The library is no longer actively developed but is maintained for compatibility with future Xcode releases. Users are directed to SwiftUI for declarative UI and SVGView for SVG support.

## Build Commands

### Swift Package Manager
```bash
# Build the project
swift build

# Run tests
swift test

# Run specific test
swift test --filter <TestName>
```

### Xcode
```bash
# Build iOS framework
xcodebuild -project Macaw.xcodeproj -scheme "Macaw iOS" -sdk iphonesimulator

# Build macOS framework
xcodebuild -project Macaw.xcodeproj -scheme "MacawOSX"

# Run iOS tests
xcodebuild test -project Macaw.xcodeproj -scheme "Macaw iOS" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 15'

# Run macOS tests
xcodebuild test -project Macaw.xcodeproj -scheme "MacawOSX"
```

### Example Project
```bash
cd Example/
pod install
open Example.xcworkspace/
```

### Linting
```bash
# Run SwiftLint (configuration in .swiftlint.yml)
swiftlint lint

# Auto-fix issues
swiftlint --fix
```

## Architecture

### Core Components

**MacawView** (`Source/views/MacawView.swift`)
- Main entry point for embedding Macaw scenes into UIKit/AppKit
- Wraps a `DrawingView` that handles rendering
- Provides zoom capabilities via `MacawZoom`
- Supports touch/gesture events and content layout

**Scene Graph** (`Source/model/scene/`)
- `Node`: Base class for all scene elements with transform, opacity, clipping, masking, and effects
- `Group`: Container node that holds child nodes
- `Shape`: Node that renders geometric shapes with fill and stroke
- `Text`: Node for rendering text with font and alignment
- `Image`: Node for displaying bitmap images

**Geometry** (`Source/model/geom2d/`)
- `Locus`: Abstract base for all geometric shapes
- Concrete shapes: `Circle`, `Ellipse`, `Rect`, `RoundRect`, `Line`, `Arc`, `Polygon`, `Polyline`, `Path`
- `Transform`: Affine transformations (translate, scale, rotate, shear)
- `Point`, `Size`, `Insets`: Basic geometric primitives

**Drawing** (`Source/model/draw/`)
- `Fill`: Solid colors, gradients, or patterns
- `Stroke`: Line styling with cap, join, dash patterns
- `Color`: RGBA color representation with named colors
- `Gradient`: `LinearGradient` and `RadialGradient`
- `Effect`: Visual effects like blur, alpha, color matrix

**Rendering** (`Source/render/`)
- `NodeRenderer`: Base renderer that dispatches to specialized renderers
- `ShapeRenderer`: Renders geometric shapes with fills and strokes
- `TextRenderer`: Renders text nodes
- `ImageRenderer`: Renders bitmap images
- `GroupRenderer`: Recursively renders child nodes
- `RenderUtils`: Core graphics utilities for drawing

**Animation** (`Source/animation/`)
- `Animation`: Protocol for all animations
- `AnimationImpl`: Concrete animation implementation
- `AnimationProducer`: Factory for creating animations
- `AnimatableVariable`: Observable variable that can be animated
- `Easing`: Timing functions for animations
- `types/`: Specific animation types (opacity, transform, morphing, etc.)

**SVG Support** (`Source/svg/`)
- `SVGParser`: Parses SVG XML into Macaw scene graph (main file is 85KB+)
- `SVGSerializer`: Converts Macaw scene graph back to SVG
- `SVGView`: Convenience view for loading SVG files
- `CSSParser`: Parses CSS styles in SVG
- `SVGConstants`: SVG element and attribute names

**Events** (`Source/events/`)
- Touch events: `TouchEvent` with pressed/moved/released handlers
- Gesture events: `TapEvent`, `PanEvent`, `PinchEvent`, `RotateEvent`
- Event handling is integrated into `Node` base class

**Platform Abstraction** (`Source/platform/`)
- Cross-platform types for iOS and macOS compatibility
- Separate files for iOS vs macOS implementations (e.g., `MCAMediaTimingFillMode_iOS.swift` vs `MCAMediaTimingFillMode_macOS.swift`)

### Key Design Patterns

**Scene Graph Pattern**: Hierarchical tree of `Node` objects that can be transformed, styled, and animated independently.

**Variable Binding** (`Source/bindings/`): Observable variables that automatically update the UI when changed, enabling reactive programming.

**Renderer Pattern**: Separate rendering logic from scene graph model. Each node type has a corresponding renderer.

**Platform Abstraction**: iOS and macOS differences are handled through separate implementation files with common interfaces.

## Dependencies

- **SWXMLHash**: XML parsing library used for SVG parsing (version 6.0.0+)

## Testing

Tests are in `MacawTests/`:
- `MacawTests.swift`: Basic functionality tests
- `MacawSVGTests.swift`: SVG parsing and rendering tests
- `SVGParserTest.swift`: SVG parser unit tests
- `SceneSerialization.swift`: Scene graph serialization tests
- `w3cSVGTests/`: W3C SVG test suite
- `svg/` and `png/`: Test fixtures

## Platform Support

- iOS 9.0+
- macOS 10.12+
- Swift 5.3+

## Important Notes

- This library is **deprecated** and in maintenance mode only
- No new features or bug fixes are planned
- Focus on compatibility with new Xcode releases
- Many SwiftLint rules are disabled (see `.swiftlint.yml`) due to legacy code
- The codebase has cross-platform support with separate iOS/macOS implementations for platform-specific APIs
