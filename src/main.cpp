#include <vector>
#include <unordered_map>
#include <iostream>
#include <format>
#include <string>
#include <unordered_map>
#include <fstream>
#include <string_view>


struct ProgramArgs
{
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

	for(auto i = 0; i < argc; i++)
	{
     		std::string arg = argv[i];
		if(arg[0] == '-'){
			// TODO: check if valid option here, also check if grouped options
			std::string plain_arg = arg.substr(1, arg.size() - 1);
			args.opts.push_back(plain_arg);
		} else {
			args.files.push_back(arg);
		}

	}

	return args;
}


int main(int argc, char** argv)
{
	ProgramArgs args = process_arguments(argc, argv);

	for(const auto& file : args.files)
	{
	     std::cout << file << std::endl;
	}

	for(const auto& opt : args.opts)
	{
	     std::cout << opt << std::endl;
	}

	return 0;
}

