use ffi::MessageWrapper;

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        type RustApp;

        #[swift_bridge(init)]
        fn new() -> RustApp;

        fn icu_message_format(&self, message_wrapper: MessageWrapper, options: ParserOptions) -> Option<String>;
    }
    
    #[swift_bridge(swift_repr = "struct")]
    struct MessageWrapper {
        message: String
    }

    #[swift_bridge(swift_repr = "struct")]
    struct ParserOptions {
        ignore_tag: bool,
        requires_other_clause: bool,
        should_parse_skeletons: bool,
        capture_location: bool,
        locale: String,
    }
}

pub struct RustApp { }

impl RustApp {
    pub fn new() -> RustApp {
        RustApp {}
    }

    fn icu_message_format(&self, message_wrapper: MessageWrapper, options: ffi::ParserOptions) -> Option<String> {
        let mut parser = icu_messageformat_parser::Parser::new(
            &message_wrapper.message, 
            &icu_messageformat_parser::ParserOptions::new(
                options.ignore_tag,
                options.requires_other_clause,
                options.should_parse_skeletons,
                options.capture_location,
                if options.locale.is_empty() { None } else { Some(options.locale) }
            )
        );
        let parsed = parser.parse();
        match parsed {
            Ok(ast) => {
                let json_str = serde_json::to_string(&ast);
                match json_str {
                    Ok(str) => Some(str),
                    Err(_e) => None
                }
            },
            Err(_e) => None,
        }
    }
}
