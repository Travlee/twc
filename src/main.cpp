#include <vector>
#include <unordered_map>
#include <iostream>
#include <format>
#include <string>


struct Test
{
};

std::vector<std::string> process_arguments(int argc, char** argv)
{
	if(argc < 2){
		std::cerr << "Missing filename!" << std::endl;
		std::exit(EXIT_FAILURE);
	}

	std::vector<std::string> arguments;
	return arguments;
}


int main(int argc, char** argv)
{
	std::vector<std::string> arguments = process_arguments(argc, argv);


	std::cout << "Testing" << std::endl;
	std::cout << std::format("test {}", "test") << std::endl;
	return 0;
}

