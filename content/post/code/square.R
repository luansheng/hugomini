require(Rcpp)
require(inline)
inc <- '
  template <typename T>
  class square : public std::unary_function<T,T> {
  public:
    T operator()( T t) const { return t*t;}
  };
'

src <- '
  double x = Rcpp::as<double>(xs);
  int i = Rcpp::as<int>(is);
  square<double> sqdbl;
  square<int> sqint;
  Rcpp::DataFrame df =
    Rcpp::DataFrame::create(Rcpp::Named("x", sqdbl(x)),
                            Rcpp::Named("i",sqint(i)));
    return df;
'

fun <- cxxfunction(signature(xs="numeric", is="integer"),
                   body=src, include=inc, plugin="Rcpp")
fun(2.2, 3L)