// The Swift Programming Language
// https://docs.swift.org/swift-book


@attached(member, names: arbitrary)
public macro IdeaAPIDescriptor() = #externalMacro(module: "IdeaAPIDescriptorMacros", type: "IdeaAPIDescriptor")

public protocol IdeaAPIDescription {
    static var name: String { get }
    static var description: String { get }
}
