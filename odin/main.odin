package wc

import "core:fmt"
import "core:os"
import "core:unicode/utf8"

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

	// fmt.println("All args: ", os.args)

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
	fmt.println("Process file here")
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
	// 		fmt.println("Doing words!")
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
