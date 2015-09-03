
#include "seqHMM.h"
using namespace Rcpp;


// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::export]]

NumericVector forwardx(NumericVector transitionMatrix, NumericVector emissionArray, 
  NumericVector initialProbs, IntegerVector obsArray, NumericMatrix coefs, 
  NumericMatrix X_, IntegerVector numberOfStates) {  
  
  IntegerVector eDims = emissionArray.attr("dim"); //m,p,r
  IntegerVector oDims = obsArray.attr("dim"); //k,n,r
  
  
  arma::colvec init(initialProbs.begin(),eDims[0],true);
  arma::mat transition(transitionMatrix.begin(),eDims[0],eDims[0],true);
  arma::cube emission(emissionArray.begin(), eDims[0], eDims[1], eDims[2],true);
  arma::Cube<int> obs(obsArray.begin(), oDims[0], oDims[1], oDims[2],false);
  
  int q = coefs.nrow();
  arma::mat coef(coefs.begin(),q,coefs.ncol());
  coef.col(0).zeros();
  arma::mat X(X_.begin(),oDims[0],q);
  arma::mat lweights = exp(X*coef).t();
  lweights.each_row() /= sum(lweights,0);
  lweights = log(lweights);   
  transition = log(transition); 
  emission = log(emission); 
  init = log(init); 
  
  arma::mat initk(eDims[0],oDims[0]);
  for(int k = 0; k < oDims[0]; k++){    
    initk.col(k) = init + reparma(lweights.col(k),numberOfStates);
  }
  arma::cube alpha(eDims[0],oDims[1],oDims[0]); //m,n,k  
  internalForwardx(transition, emission, initk, obs, alpha);
  
  return wrap(alpha);
}