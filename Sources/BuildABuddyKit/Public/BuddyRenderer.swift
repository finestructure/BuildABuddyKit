import UIKit

public struct BuddyRenderer {
    public var backgroundColor: UIColor?
    public var canvasSize: CGSize

    public init(backgroundColor: UIColor? = nil, canvasSize: CGSize = CGSize(width: 600, height: 600)) {
        self.backgroundColor = backgroundColor
        self.canvasSize = canvasSize
    }

    public func render(_ buddy: Buddy) -> UIImage {
        let scale = CGPoint(x: canvasSize.width / 600, y: canvasSize.height / 600)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        format.opaque = false
        let renderer = UIGraphicsImageRenderer(size: canvasSize, format: format)
        let data = renderer.pngData { context in
            let cgContext = context.cgContext
            let rect = CGRect(origin: .zero, size: canvasSize)
            cgContext.clear(rect)
            cgContext.setFillColor(UIColor.clear.cgColor)
            cgContext.fill(rect)
            if let backgroundColor = backgroundColor {
                cgContext.setFillColor(backgroundColor.cgColor)
                cgContext.fill(rect)
            }
            for asset in buddy.assets {
                if let image = asset.image {
                    // Rotate the image and then render the rotated image. This makes it easier to transfer values from Sketch to code.
                    let transformedImage = image.flipped(asset.flipped).rotated(by: asset.rotation)
                    cgContext.saveGState()
                    cgContext.scaleBy(x: scale.x, y: scale.y)
                    transformedImage.draw(at: asset.position)
                    cgContext.restoreGState()
                }
            }
        }
        return UIImage(data: data)!
    }
}
