#include <Rcpp.h>

int fibonacci(const int x) {
  if (x == 0) return(0);
  if (x == 1) return(1);
  return fibonacci(x - 1) + fibonacci(x - 2);
}

extern "C" SEXP fibWrapper(SEXP xs) {
  int x = Rcpp::as<int>(xs);
  int fib = fibonacci(x);
  return (Rcpp::wrap(fib));
}