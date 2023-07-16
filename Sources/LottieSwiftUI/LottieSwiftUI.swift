import Foundation
import Lottie
import SwiftUI

#if os(iOS)
    import UIKit
    typealias ViewRepresentable = UIViewRepresentable
#endif
#if os(macOS)
    import AppKit
    typealias ViewRepresentable = NSViewRepresentable
#endif

public struct LottieView: ViewRepresentable {
    private let iconName: String

    private var configuration: Configuration

    public init(
        iconName: String,
        bundle: Bundle,
        loopMode: LottieLoopMode = .playOnce,
        renderEngine: RenderingEngineOption = .coreAnimation
    ) {
        self.iconName = iconName
        configuration = .init(
            loopMode: loopMode,
            renderEngine: renderEngine,
            bundle: bundle
        )
    }

    #if os(iOS)
        public typealias UIViewType = UIView
    #endif
    #if os(macOS)
        public typealias NSViewType = NSView
    #endif

    private func makeAnimationView() -> LottieAnimationView {
        let v = LottieAnimationView(
            name: iconName,
            bundle: configuration.bundle,
            imageProvider: nil,
            animationCache: nil,
            // https://github.com/airbnb/lottie-ios/discussions/1627
            configuration: LottieConfiguration(renderingEngine: configuration.renderEngine)
        )
        v.play()
        v.loopMode = configuration.loopMode
        v.contentMode = .scaleAspectFit
        v.backgroundBehavior = .pauseAndRestore
        return v
    }

    #if os(iOS)
        public func makeUIView(context _: Context) -> UIView {
            let containerView = UIView()
            let animationView = makeAnimationView()

            containerView.addSubview(animationView)

            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
                animationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
                animationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
                animationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            ])

            return containerView
        }

        public func updateUIView(_ uiView: UIView, context _: Context) {
            guard let animationView = uiView.subviews.first as? LottieAnimationView else {
                return
            }
            updateAnimationView(animationView)
        }
    #endif

    #if os(macOS)
        public func makeNSView(context _: Context) -> NSView {
            let containerView = NSView()
            let animationView = makeAnimationView()

            containerView.addSubview(animationView)

            animationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                animationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
                animationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
                animationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
                animationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            ])

            return containerView
        }

        public func updateNSView(_ nsView: NSView, context _: Context) {
            guard let animationView = nsView.subviews.first as? LottieAnimationView else {
                return
            }
            updateAnimationView(animationView)
        }
    #endif

    private func updateAnimationView(_ animationView: LottieAnimationView) {
        if !animationView.isAnimationPlaying,
           configuration.loopMode != .playOnce
        {
            animationView.play()
        }
    }
}

public extension LottieView {
    private struct Configuration {
        var loopMode: LottieLoopMode = .playOnce
        var renderEngine: RenderingEngineOption = .coreAnimation
        var bundle: Bundle
    }
}
