import RustXcframework
public func hello_rust() -> RustString {
    RustString(ptr: __swift_bridge__$hello_rust())
}
public func icu_message_format<GenericToRustStr: ToRustStr>(_ message: GenericToRustStr) -> Optional<RustString> {
    return message.toRustStr({ messageAsRustStr in
        { let val = __swift_bridge__$icu_message_format(messageAsRustStr); if val != nil { return RustString(ptr: val!) } else { return nil } }()
    })
}


