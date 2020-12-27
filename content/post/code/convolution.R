##记得在文件开始行加载Rcpp和inline两个包，不然会找不到Rcpp调用的类型和函数
require(Rcpp)
require(inline)
##定义C++代码
src <- '
Rcpp::NumericVector xa(a);
Rcpp::NumericVector xb(b);
int n_xa =xa.size(), n_xb = xb.size();

Rcpp::NumericVector xab(n_xa + n_xb-1);
for (int i=0; i < n_xa; i++)
  for (int j=0; j < n_xb; j++)
    xab[i+j] += xa[i] * xb[j];
return xab;
'

###定义在R中调用的接口函数
fun <- cxxfunction(signature(a="numeric",b="numeric"),
                   src,plugin="Rcpp")
funverbose <- cxxfunction(signature(a="numeric",b="numeric"),
                          src,plugin="Rcpp",verbose = TRUE)
#利用rcpp函数定义接口函数
funrcpp <-  rcpp(signature(a="numerci",b="numeric"),src)
fun(1:4,2:5)
funverbose(1:4,2:5)
funrcpp(1:4, 2:5)

