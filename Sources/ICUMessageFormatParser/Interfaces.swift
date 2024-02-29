import Foundation

public enum ICUMessageFormatParser {
  
  private static let jsonDecoder: JSONDecoder = .init()
  
  public static func parse(
    _ message: String,
    options: ICUMessageFormatParserOptions
  ) throws -> Ast {
    
    guard let json = icu_message_format(.init(message: .init(message)), options._parserOptions)?.toString() else {
      throw ICUMessageFormatParserError.invalidJSON
    }
    
    guard let data = json.data(using: .utf8) else {
      throw ICUMessageFormatParserError.invalidJSON
    }
    
    let ast = try jsonDecoder.decode(Ast.self, from: data)
    return ast
  }
  
}

public struct ICUMessageFormatParserOptions {
  
  let _parserOptions: ParserOptions
  
  public init(
    ignoreTag: Bool,
    requiresOtherClause: Bool,
    shouldParseSkeletons: Bool,
    captureLocation: Bool,
    locale: String?
  ) {
    self._parserOptions = ParserOptions(
      ignore_tag: ignoreTag,
      requires_other_clause: requiresOtherClause,
      should_parse_skeletons: shouldParseSkeletons,
      capture_location: captureLocation,
      locale: .init(locale ?? "")
    )
  }
  
}

public enum ICUMessageFormatParserError: Error {
  case invalidJSON
}
