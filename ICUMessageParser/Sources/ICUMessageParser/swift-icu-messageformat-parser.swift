import RustXcframework
public func icu_message_format<GenericToRustStr: ToRustStr>(_ message: GenericToRustStr, _ options: ParserOptions) -> Optional<RustString> {
    return message.toRustStr({ messageAsRustStr in
        { let val = __swift_bridge__$icu_message_format(messageAsRustStr, options.intoFfiRepr()); if val != nil { return RustString(ptr: val!) } else { return nil } }()
    })
}
public struct ParserOptions {
    public var ignore_tag: Bool
    public var requires_other_clause: Bool
    public var should_parse_skeletons: Bool
    public var capture_location: Bool
    public var locale: RustString

    public init(ignore_tag: Bool,requires_other_clause: Bool,should_parse_skeletons: Bool,capture_location: Bool,locale: RustString) {
        self.ignore_tag = ignore_tag
        self.requires_other_clause = requires_other_clause
        self.should_parse_skeletons = should_parse_skeletons
        self.capture_location = capture_location
        self.locale = locale
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$ParserOptions {
        { let val = self; return __swift_bridge__$ParserOptions(ignore_tag: val.ignore_tag, requires_other_clause: val.requires_other_clause, should_parse_skeletons: val.should_parse_skeletons, capture_location: val.capture_location, locale: { let rustString = val.locale.intoRustString(); rustString.isOwned = false; return rustString.ptr }()); }()
    }
}
extension __swift_bridge__$ParserOptions {
    @inline(__always)
    func intoSwiftRepr() -> ParserOptions {
        { let val = self; return ParserOptions(ignore_tag: val.ignore_tag, requires_other_clause: val.requires_other_clause, should_parse_skeletons: val.should_parse_skeletons, capture_location: val.capture_location, locale: RustString(ptr: val.locale)); }()
    }
}
extension __swift_bridge__$Option$ParserOptions {
    @inline(__always)
    func intoSwiftRepr() -> Optional<ParserOptions> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<ParserOptions>) -> __swift_bridge__$Option$ParserOptions {
        if let v = val {
            return __swift_bridge__$Option$ParserOptions(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$ParserOptions(is_some: false, val: __swift_bridge__$ParserOptions())
        }
    }
}


