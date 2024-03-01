import RustXcframework

public class RustApp: RustAppRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$RustApp$_free(ptr)
        }
    }
}
extension RustApp {
    public convenience init() {
        self.init(ptr: __swift_bridge__$RustApp$new())
    }
}
public class RustAppRefMut: RustAppRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class RustAppRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension RustAppRef {
    public func icu_message_format(_ message_wrapper: MessageWrapper, _ options: ParserOptions) -> Optional<RustString> {
        { let val = __swift_bridge__$RustApp$icu_message_format(ptr, message_wrapper.intoFfiRepr(), options.intoFfiRepr()); if val != nil { return RustString(ptr: val!) } else { return nil } }()
    }
}
extension RustApp: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_RustApp$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_RustApp$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: RustApp) {
        __swift_bridge__$Vec_RustApp$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_RustApp$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (RustApp(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustAppRef> {
        let pointer = __swift_bridge__$Vec_RustApp$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustAppRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustAppRefMut> {
        let pointer = __swift_bridge__$Vec_RustApp$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustAppRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<RustAppRef> {
        UnsafePointer<RustAppRef>(OpaquePointer(__swift_bridge__$Vec_RustApp$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_RustApp$len(vecPtr)
    }
}

public struct MessageWrapper {
    public var message: RustString

    public init(message: RustString) {
        self.message = message
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$MessageWrapper {
        { let val = self; return __swift_bridge__$MessageWrapper(message: { let rustString = val.message.intoRustString(); rustString.isOwned = false; return rustString.ptr }()); }()
    }
}
extension __swift_bridge__$MessageWrapper {
    @inline(__always)
    func intoSwiftRepr() -> MessageWrapper {
        { let val = self; return MessageWrapper(message: RustString(ptr: val.message)); }()
    }
}
extension __swift_bridge__$Option$MessageWrapper {
    @inline(__always)
    func intoSwiftRepr() -> Optional<MessageWrapper> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<MessageWrapper>) -> __swift_bridge__$Option$MessageWrapper {
        if let v = val {
            return __swift_bridge__$Option$MessageWrapper(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$MessageWrapper(is_some: false, val: __swift_bridge__$MessageWrapper())
        }
    }
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


