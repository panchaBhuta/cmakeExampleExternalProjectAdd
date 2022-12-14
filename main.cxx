#include <iostream>
#include <vector>

#include <rapidcsv/view.h>
#include <cxxopts/cxxopts.hpp>
#include <cpp-properties/PropertiesParser.h>

int main(int argc, char** argv)
{
    cxxopts::Options options("MyProgram", "One line description of MyProgram");

    options.add_options()
        ("p,propfilename", "The property filename", cxxopts::value<std::string>());

    //options.parse_positional({"script", "server", "filenames"});

    std::cout << "start parse" << std::endl << std::flush;
    // Parse options the usual way
    auto result = options.parse(argc, argv);
    std::cout << "end parse" << std::endl << std::flush;
    std::string propFileName = result["propfilename"].as<std::string>();
    std::cout << "propFileName=" << propFileName << std::endl;

    cppproperties::Properties props = cppproperties::PropertiesParser::Read(propFileName);
    std::string csvFileName = props.GetPropertyExpanded("csvfilename");

    //rapidcsv::Document doc("/home/vishnu/repositories/rapidcsv_FilterSort/examples/colhdr.csv");
    rapidcsv::Document doc(csvFileName);
       
    std::vector<float> col = doc.GetColumn<float>("Close");
    std::cout << "Read " << col.size() << " values." << std::endl;

    return 0;
}
