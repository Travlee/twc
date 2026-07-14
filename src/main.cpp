#include <vector>
#include <unordered_map>
#include <iostream>
#include <format>
#include <string>
#include <unordered_map>


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
		if(argv[i][0] == '-'){
			args.opts.push_back(argv[i]);
		} else {
			args.files.push_back(argv[i]);
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

