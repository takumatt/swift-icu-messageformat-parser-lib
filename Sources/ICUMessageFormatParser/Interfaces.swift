import Foundation

public enum ICUMessageFormatParser {
  
  public static func parse(
    _ message: String,
    using decoder: JSONDecoder,
    options: ICUMessageFormatParserOptions
  ) throws -> Ast? {
    guard let json = icu_message_format(message, options._parserOptions)?.toString() else {
      return nil
    }
    
    guard let data = json.data(using: .utf8) else {
      return nil
    }
    
    let ast = try decoder.decode(Ast.self, from: data)
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