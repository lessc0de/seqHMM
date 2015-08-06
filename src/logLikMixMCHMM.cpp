
#include "seqHMM.h"
using namespace Rcpp;

// Below is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar)

// For more on using Rcpp click the Help button on the editor toolbar
// install_github( "Rcpp11/attributes" ) ; require('attributes') 

// [[Rcpp::depends(RcppArmadillo)]]
// [[Rcpp::export]]

NumericVector logLikMixMCHMM(NumericVector transitionMatrix, NumericVector emissionArray, 
NumericVector initialProbs, IntegerVector obsArray, NumericMatrix coefs, 
NumericMatrix X_, IntegerVector numberOfStates) {  
  
  
  IntegerVector eDims = emissionArray.attr("dim"); //m,p,r
  IntegerVector oDims = obsArray.attr("dim"); //k,n,r
  
  NumericVector ll(oDims[0]);  
  int q = coefs.nrow();
  arma::mat coef(coefs.begin(),q,coefs.ncol());
  coef.col(0).zeros();
  arma::mat X(X_.begin(),oDims[0],q);
  arma::mat lweights = exp(X*coef).t();
  if(!lweights.is_finite()){
    return -std::numeric_limits<double>::max();
  }
  lweights.each_row() /= sum(lweights,0);
  arma::colvec init(initialProbs.begin(),eDims[0]);
  arma::mat transition(transitionMatrix.begin(),eDims[0],eDims[0]);
  arma::cube emission(emissionArray.begin(), eDims[0], eDims[1], eDims[2]);
  arma::Cube<int> obs(obsArray.begin(), oDims[0], oDims[1], oDims[2]);
  
  arma::vec alpha(eDims[0]); //m,n,k
  arma::vec alphatmp(eDims[0]); //m,n,k  
  double tmp;
  
  
  lweights = log(lweights); 
  transition = log(transition); 
  emission = log(emission); 
  init = log(init); 
  
  double sumtmp; 
  double neginf = -arma::math::inf();   
  
  arma::vec initk(eDims[0]);
  
  for(int k = 0; k < oDims[0]; k++){    
    initk = init + reparma(lweights.col(k),numberOfStates);
    for(int i=0; i < eDims[0]; i++){      
      alpha(i) = initk(i);
      for(int r = 0; r < oDims[2]; r++){
        alpha(i) += emission(i,obs(k,0,r),r);
      }
    }    
    
    for(int t = 1; t < oDims[1]; t++){  
      for(int i = 0; i < eDims[0]; i++){
        sumtmp = neginf;
        for(int j = 0; j < eDims[0]; j++){
          tmp = alpha(j) + transition(j,i);
          if(tmp > neginf){
            sumtmp = logSumExp(sumtmp,tmp);
          }
        }
        
        for(int r = 0; r < oDims[2]; r++){
          sumtmp += emission(i,obs(k,t,r),r);
        }
        alphatmp(i) = sumtmp;
      }
      alpha = alphatmp;
      
    }
    
    
    tmp = neginf;
    for(int i = 0; i < eDims[0]; i++){
      if(alpha(i)>neginf){
        tmp = logSumExp(alpha(i),tmp); 
      }
    }
    ll(k) = tmp;    
    
  }  
  
  return ll;
}

