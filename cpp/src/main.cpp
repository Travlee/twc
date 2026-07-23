#include <vector>
#include <iostream>
#include <format>
#include <string>
#include <unordered_map>
#include <fstream>

constexpr short OPT_WORDS = 0b000001;
constexpr short OPT_LINES = 0b000010;
constexpr short OPT_CHARS = 0b000100;
constexpr short OPT_BYTES = 0b001000;
constexpr short OPT_LONGEST_LINE = 0b010000;
constexpr short OPT_HELP = 0b100000;

struct ProgramArgs
{
	int options = 0;
	std::vector<std::string> files;
	std::vector<std::string> opts;
};

ProgramArgs process_arguments(int argc, char** argv)
{
	if(argc < 2){
		std::cerr << "Missing filename!" << std::endl;
		std::exit(EXIT_FAILURE);
	}

	ProgramArgs args;

	for(auto i = 1; i < argc; i++)
	{
     		std::string arg = argv[i];
		if(arg[0] == '-'){
			// TODO: check if valid option here, also check if grouped options
			std::string plain_arg = arg.substr(1, arg.size() - 1);
			args.opts.push_back(plain_arg);

			if(plain_arg == "w"){
				args.options = args.options | OPT_WORDS;
			}
			if(plain_arg == "l"){
				args.options = args.options | OPT_LINES;
			}
			if(plain_arg == "m"){
				args.options = args.options | OPT_CHARS;
			}
			if(plain_arg == "c"){
				args.options = args.options | OPT_BYTES;
			}
			if(plain_arg == "L"){
				args.options = args.options | OPT_LONGEST_LINE;
			}
			if(plain_arg == "h"){
				args.options = args.options | OPT_HELP;
			}

		} else {
			args.files.push_back(arg);
		}

	}

	return args;
}


int main(int argc, char** argv)
{
	ProgramArgs args = process_arguments(argc, argv);

	//for(const auto& file : args.files)
	//{
	//     std::cout << file << std::endl;
	//}

	//for(const auto& opt : args.opts)
	//{
	//     std::cout << opt << std::endl;
	//}

	std::cout << (args.options & OPT_WORDS) << std::endl;

	return 0;
}

