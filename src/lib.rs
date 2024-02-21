use icu_messageformat_parser::ParserOptions;

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        fn hello_rust() -> String;
        fn icu_message_format(message: &str) -> Option<String>;
    }
}

fn hello_rust() -> String {
    "Hello, Rust!".to_string()
}

fn icu_message_format<'a>(message: &'a str) -> Option<String> {
    let mut parser = icu_messageformat_parser::Parser::new(message, &ParserOptions::new(false, false, false, false, None));
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
