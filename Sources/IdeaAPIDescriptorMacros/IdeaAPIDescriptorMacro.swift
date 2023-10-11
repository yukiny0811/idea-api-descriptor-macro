import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

internal struct IdeaData {
    var name: String
    var description: String
}

public struct IdeaAPIDescriptor: MemberMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        
        let cases: [IdeaData] = declaration.memberBlock.members
            .map { memberBlockItem in
                let name = memberBlockItem
                    .decl
                    .as(EnumCaseDeclSyntax.self)!
                    .elements
                    .first!
                    .name
                    .text
                let description = memberBlockItem
                    .decl
                    .as(EnumCaseDeclSyntax.self)!
                    .elements
                    .first!
                    .rawValue!
                    .value
                    .as(StringLiteralExprSyntax.self)!
                    .segments
                    .first!
                    .description
                return IdeaData(name: name, description: description)
            }
        
        var nameMethod = "" + "\n"
        nameMethod += "func name() -> String {" + "\n"
        nameMethod += "    switch self {" + "\n"
        for c in cases {
            nameMethod += "    case .\(c.name):" + "\n"
            nameMethod += "        return \"\(c.name)\"" + "\n"
        }
        nameMethod += "    }" + "\n"
        nameMethod += "}" + "\n"
        
        var descriptionMethod = "" + "\n"
        descriptionMethod += "func description() -> String {" + "\n"
        descriptionMethod += "    return self.rawValue" + "\n"
        descriptionMethod += "}" + "\n"
        
        var fromMethod = "" + "\n"
        fromMethod += "static func from(name: String) -> Self? {" + "\n"
        fromMethod += "    switch name {" + "\n"
        for c in cases {
            fromMethod += "    case \"\(c.name)\":" + "\n"
            fromMethod += "        return .\(c.name)" + "\n"
        }
        fromMethod += "    default:" + "\n"
        fromMethod += "        return nil" + "\n"
        fromMethod += "    }" + "\n"
        fromMethod += "}" + "\n"
        
        return [DeclSyntax(stringLiteral: nameMethod + descriptionMethod + fromMethod)]
    }
}

@main
struct IdeaAPIDescriptorPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        IdeaAPIDescriptor.self,
    ]
}
