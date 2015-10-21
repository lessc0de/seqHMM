#include "seqHMM.h"
using namespace Rcpp;

// [[Rcpp::depends(RcppArmadillo)]]

unsigned int log_optCoef(arma::mat& weights, const arma::icube& obs, const arma::cube& emission, const arma::mat& initk, 
  const arma::cube& beta, const arma::vec& ll, arma::mat& coef, const arma::mat& X, 
  const IntegerVector cumsumstate, const IntegerVector numberOfStates, int trace) {
  
  weights = exp(X*coef).t();
  weights.each_row() /= sum(weights,0);
  int iter = 0;
  double change = 1.0;
  while((change>1e-10) & (iter<100)){
    arma::vec tmpvec(X.n_cols * (weights.n_rows - 1));
    bool solve_ok = arma::solve(tmpvec, hCoef(weights, X), log_gCoef(obs, beta, emission, initk,
      weights, ll, X, cumsumstate, numberOfStates));
    
    if (solve_ok == false) {
      return (2);
    }
    
    arma::mat coefnew(coef.n_rows,coef.n_cols - 1);
    for (unsigned int i = 0; i < (weights.n_rows - 1); i++) {
      coefnew.col(i) = coef.col(i + 1) - tmpvec.subvec(i * X.n_cols, (i + 1) * X.n_cols - 1);
    }
    change = arma::accu(arma::abs(coef.submat(0, 1, coef.n_rows - 1, coef.n_cols - 1) - coefnew))
      / coefnew.n_elem;
    coef.submat(0, 1, coef.n_rows - 1, coef.n_cols - 1) = coefnew;
    iter++;
    if (trace == 3) {
      Rcout << "coefficient optimization iter: " << iter;
      Rcout << " new coefficients: " << std::endl << coefnew << std::endl;
      Rcout << " relative change: " << change << std::endl;
    }
    weights = exp(X * coef).t();
    if (!weights.is_finite()) {
      return (3);
    }
    weights.each_row() /= sum(weights, 0);
    
  }
  weights = log(weights);
  return (0);
}


arma::vec log_gCoef(const arma::icube& obs, const arma::cube& beta, const arma::cube& emission, const arma::mat& initk,
  const arma::mat& weights, const arma::vec& ll, const arma::mat& X, const IntegerVector cumsumstate, const IntegerVector numberOfStates) {
  
  int q = X.n_cols;
  arma::vec grad(q * (weights.n_rows - 1) ,arma::fill::zeros);
  double tmp;
  for(unsigned int jj = 1; jj < numberOfStates.size(); jj++){
    for(int k = 0; k < obs.n_rows; k++){
      for(unsigned int j = 0; j < emission.n_rows; j++){                
        tmp = 0.0;
        for(int r=0; r < obs.n_slices; r++){
          tmp += emission(j,obs(k,0,r),r);
        }        
        if(j>=(cumsumstate(jj)-numberOfStates(jj)) & j<cumsumstate(jj)){
          grad.subvec(q*(jj-1),q*jj-1) += 
            exp(tmp+beta(j,0,k)-ll(k)+initk(j,k))*X.row(k).t()*(1.0 - weights(jj,k)); 
        } else {
          grad.subvec(q*(jj-1),q*jj-1) -= 
            exp(tmp+beta(j,0,k)-ll(k)+initk(j,k))*X.row(k).t()*weights(jj,k);
        }
        
      }
    }
  }
  
  return grad;
}