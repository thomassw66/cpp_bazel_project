#include <ctime>
#include <iostream>
#include <ranges>
#include <string>
#include <vector>
#include <print>

std::string get_greet(const std::string &who) { return "Hello " + who; }

void print_localtime() {
  std::time_t result = std::time(nullptr);
  std::cout << std::asctime(std::localtime(&result));
}

int main(int argc, char **argv) {
  std::string who = "world";
  if (argc > 1) {
    who = argv[1];
  }
  std::cout << get_greet(who) << std::endl;
  print_localtime();

  std::vector<int> vals{1, 2, 3, 4, 5};
  for (auto x : vals | std::views::transform([](auto x) { return 2.0 * x; })) {
		std::print("{}\n", x);
  }

  return 0;
}
