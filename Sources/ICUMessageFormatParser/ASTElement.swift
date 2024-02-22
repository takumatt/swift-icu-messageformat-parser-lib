import Foundation

public typealias Ast = [AstElement]

public enum AstElement: Decodable {
  /// Raw text
  case literal(LiteralElement)
  
  /// Variable w/o any format, e.g `var` in `this is a {var}`
  case argument(ArgumentElement)
  
  /// Variable w/ number format
  case number(NumberElement)
  
  /// Variable w/ date format
  case date(DateElement)
  
  /// Variable w/ time format
  case time(TimeElement)
  
  /// Variable w/ select format
  case select(SelectElement)
  
  /// Variable w/ plural format
  case plural(PluralElement)
  
  /// Only possible within plural argument.
  /// This is the `#` symbol that will be substituted with the count.
  case pound(PoundElement)
  
  /// XML-like tag
  case tag(TagElement)
  
  private enum CodingKeys: String, CodingKey {
    case type
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let reportType = try container.decode(AstElementType.self, forKey: .type)
    
    switch reportType {
    case .literal:
      self = .literal(try LiteralElement(from: decoder))
    case .argument:
      self = .argument(try ArgumentElement(from: decoder))
    case .number:
      self = .number(try NumberElement(from: decoder))
    case .date:
      self = .date(try DateElement(from: decoder))
    case .time:
      self = .time(try TimeElement(from: decoder))
    case .select:
      self = .select(try SelectElement(from: decoder))
    case .plural:
      self = .plural(try PluralElement(from: decoder))
    case .pound:
      self = .pound(try PoundElement(from: decoder))
    case .tag:
      self = .tag(try TagElement(from: decoder))
    }
  }
}

enum AstElementType: Int, Decodable {
  case literal = 0
  case argument = 1
  case number = 2
  case date = 3
  case time = 4
  case select = 5
  case plural = 6
  case pound = 7
  case tag = 8
}

// MARK: - Element

public struct LiteralElement: Decodable {
  public let value: String
  public let span: Span?
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
  }
}

public struct ArgumentElement: Decodable {
  public let value: String
  public let span: Span?
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
  }
}

public struct NumberElement: Decodable {
  let value: String
  let span: Span?
  let style: NumberArgStyle?
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
    case style
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
    style = try container.decodeIfPresent(NumberArgStyle.self, forKey: .style)
  }
}

public struct DateElement: Decodable {
  public let value: String
  public let span: Span?
  public let style: DateTimeArgStyle?
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
    case style
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
    style = try container.decodeIfPresent(DateTimeArgStyle.self, forKey: .style)
  }
}

public struct TimeElement: Decodable {
  public let value: String
  public let span: Span?
  public let style: DateTimeArgStyle?
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
    case style
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
    style = try container.decodeIfPresent(DateTimeArgStyle.self, forKey: .style)
  }
}

public struct SelectElement: Decodable {
  public let value: String
  public let span: Span?
  public var options: [String : PluralOrSelectOptions]
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
    case options
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
    self.options = .init()
    if let subContainer = try? container.nestedContainer(keyedBy: GenericCondingKeys.self, forKey: .options) {
      for key in subContainer.allKeys {
        if let value = try? subContainer.decode(PluralOrSelectOptions.self, forKey: key) {
          self.options[key.stringValue] = value
        }
      }
    }
  }
}

public struct PluralElement: Decodable {
  public let value: String
  public let pluralType: PluralType
  public let span: Span?
  public let offset: Int
  public var options: [String : PluralOrSelectOptions]
  
  private enum CodingKeys: String, CodingKey {
    case value
    case pluralType
    case location
    case offset
    case options
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    pluralType = try container.decode(PluralType.self, forKey: .pluralType)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
    offset = try container.decode(Int.self, forKey: .offset)
    
    self.options = .init()
    if let subContainer = try? container.nestedContainer(keyedBy: GenericCondingKeys.self, forKey: .options) {
      for key in subContainer.allKeys {
        if let value = try? subContainer.decode(PluralOrSelectOptions.self, forKey: key) {
          self.options[key.stringValue] = value
        }
      }
    }
  }
  
}

public struct PoundElement: Decodable {
  public let span: Span?
  
  private enum CodingKeys: String, CodingKey {
    case location
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
  }
}

public struct TagElement: Decodable {
  public let value: String
  public let span: Span?
  public let children: Ast
  
  private enum CodingKeys: String, CodingKey {
    case value
    case location
    case children
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(String.self, forKey: .value)
    span = try container.decodeIfPresent(Span.self, forKey: .location)
    children = try container.decode(Ast.self, forKey: .children)
  }
}

// MARK: - Children

public struct Span: Decodable {
  public let start: Position
  public let end: Position
}

public enum NumberArgStyle: Decodable {
  case style(String)
  case skeleton(NumberSkeleton)
}

public enum DateTimeArgStyle: Decodable {
  case style(String)
  case skeleton(DateTimeSkeleton)
}

public struct PluralOrSelectOptions: Decodable {
  public let value: Ast
  public let location: Span?
}

public enum PluralType: String, Decodable {
  case cardinal
  case ordinal
}

public struct Position: Decodable {
  public let offset: Int
  public let line: Int
  public let column: Int
}

public enum SkeletonType: Decodable {
  case number
  case dateTime
}

public struct DateTimeSkeleton: Decodable {
  public let skeletonType: SkeletonType
  public let pattern: String
  public let location: Span?
  // public let parsedOptions:
}

public struct NumberSkeleton: Decodable {
  public let skeletonType: SkeletonType
  public let tokens: [NumberSkeletonToken]
  public let location: Span?
  // public let parsedOptions:
}

public struct NumberSkeletonToken: Decodable {
  public let stem: String
  public let options: [String]
}

// MARK: CodingKeys

class GenericCondingKeys: CodingKey {

  var stringValue: String
  var intValue: Int?
  
  required init?(intValue: Int) {
    self.intValue = intValue
    self.stringValue = "\(intValue)"
  }

  required init?(stringValue: String) {
    self.stringValue = stringValue
  }
  
}
