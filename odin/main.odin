package wc

import "core:fmt"
import "core:os"
import "core:unicode/utf8"
import "core:strings"

Option :: enum {
	Words,
	Lines,
	Chars,
	Bytes,
	LongestLineLen,
	Help
}


ProgramArgs :: struct {
	options: bit_set[Option; u8],
	files: [dynamic]string
}

process_args :: proc() -> ProgramArgs{
	processed_args: ProgramArgs

	if len(os.args) < 2 {
		fmt.eprintln("No args")
		os.exit(1)
	}

	extracted_arg_chars: [dynamic]string
	actual_args := os.args[1:]

	for arg in actual_args {
		if len(arg) == 0 {
			// TODO: throw error here, probably
			fmt.println("empty arg!")
			continue
		}

		if arg == "--help" {
			
			processed_args.options += {Option.Help}
			break
		}

		char, _ := utf8.decode_rune_in_string(arg)
		if char == '-' {
			for char, _ in arg {
				if char == 'c'{
					processed_args.options += {Option.Bytes}
				} else if char == 'w' {
					processed_args.options += {Option.Words}
				} else if char == 'l' {
					processed_args.options += {Option.Lines}
				} else if char == 'L' {
					processed_args.options += {Option.LongestLineLen}
				} else if char == 'm' {
					processed_args.options += {Option.Chars}
				}
			}

		} else {
			append(&processed_args.files, arg)
		}
	}

	return processed_args
}


print_help :: proc() {
	fmt.println("Usage: twc [OPTION]... [FILE]...")
	fmt.println("-c, --bytes            print the byte counts")
	fmt.println("-m, --chars            print the character counts")
	fmt.println("-l, --lines            print the newline counts")
	fmt.println("-L, --max-line-length  print the maximum line length")
	fmt.println("-w, --words            print the word counts")
}


process_file :: proc(args: ^ProgramArgs) {

	data, ferr := os.read_entire_file(args.files[0], context.allocator)

	if ferr != nil {
		fmt.eprintln("Failed opening file!", args.files[0], ferr)
		return
	}

	defer delete(data, context.allocator)

	output := strings.builder_make()
	
	word_count := 0
	char_count := 0
	line_count := 0
	max_line_length := 0
	byte_count := 0

	it := string(data)
	for line in strings.split_lines_iterator(&it) {
		if .Words in args.options {
			words_in_line := count_words_in_line(line)
			word_count += words_in_line
		}

		if .Chars in args.options {
			chars_in_line := count_chars_in_line(line)
			char_count += chars_in_line
		}

		if .Lines in args.options {
			line_count += 1
		}
	}

	// formatting change
	strings.write_rune(&output, ' ')

	if line_count != 0 {
		strings.write_int(&output, line_count)
		strings.write_rune(&output, ' ')
	}

	if word_count != 0 {
		strings.write_int(&output, word_count)
		strings.write_rune(&output, ' ')
	}

	if char_count != 0 {
		strings.write_int(&output, char_count)
		strings.write_rune(&output, ' ')
	}

	strings.write_string(&output, args.files[0])

	fmt.println(strings.to_string(output))
}


count_words_in_line :: proc(line: string) -> int {
	word_count := 0

	for char, index in line {
		if char == ' ' {
			word_count += 1
		}
	}

	word_count += 1
	return word_count
}

count_chars_in_line :: proc(line: string) -> int {
	char_count := 0

	for char in line {
		char_count += 1
	}
	
	// fix for missing line ending
	char_count += 1

	return char_count
}


main :: proc() {
	args := process_args()
	defer delete(args.files)

	fmt.println("Args: ", args)

	if .Help in args.options {
		print_help()
		os.exit(0)
	}

	if len(args.files) == 0 {
		fmt.eprintln("Missing file!")
	}

	process_file(&args)


	// for option in args.options {
	// 	fmt.println("Active opt: ", option)
	//
	// 	#partial switch option {
	// 	case .Words:
	// 		count_words(&args)
	// 	case .Lines:
	// 		fmt.println("Doing lines!")
	// 	case .Chars:
	// 		fmt.println("Doing Chars!")
	// 	case .LongestLineLen:
	// 		fmt.println("Doing LongestLineLen!")
	// 	case .Bytes:
	// 		fmt.println("Doing bytes!")
	// 	}
	// }

}
