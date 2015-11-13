#ifndef SEQHMM_H
#define SEQHMM_H

// [[Rcpp::plugins(openmp)]]
#ifdef _OPENMP
#include <omp.h>
#endif

#define ARMA_NO_DEBUG
#define ARMA_DONT_PRINT_ERRORS
#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;

arma::vec reparma(arma::vec x, Rcpp::IntegerVector y);

void internalForwardx(const arma::mat& transition, const arma::cube& emission,
  const arma::mat& init, const arma::icube& obs, arma::cube& alpha, arma::mat& scales, int threads);
void internalForward(const arma::mat& transition, const arma::cube& emission, 
  const arma::vec& init, const arma::icube& obs, arma::cube& alpha, arma::mat& scales, int threads);
void internalBackward(const arma::mat& transition, const arma::cube& emission, 
  const arma::icube& obs, arma::cube& beta, const arma::mat& scales, int threads);

unsigned int optCoef(arma::mat& weights, const arma::icube& obs, const arma::cube& emission, const arma::mat& initk, 
  const arma::cube& beta, const arma::mat& scales, arma::mat& coef, const arma::mat& X, 
  const Rcpp::IntegerVector cumsumstate, const Rcpp::IntegerVector numberOfStates, int trace);

arma::vec gCoef(const arma::icube& obs, const arma::cube& beta, const arma::mat& scales, const arma::cube& emission, const arma::mat& initk,
  const arma::mat& weights, const arma::mat& X, const Rcpp::IntegerVector cumsumstate, 
  const Rcpp::IntegerVector numberOfStates);

arma::mat hCoef(const arma::mat& weights, const arma::mat& X);

//log-space versions
double logSumExp(const arma::vec& x);

void log_internalForwardx(const arma::mat& transition, const arma::cube& emission,
  const arma::mat& init, const arma::icube& obs, arma::cube& alpha, int threads);

void log_internalForward(const arma::mat& transition, const arma::cube& emission, 
  const arma::vec& init, const arma::icube& obs, arma::cube& alpha, int threads);

void log_internalBackward(const arma::mat& transition, const arma::cube& emission, 
  const arma::icube& obs, arma::cube& beta, int threads);

unsigned int log_optCoef(arma::mat& weights, const arma::icube& obs, const arma::cube& emission, const arma::mat& initk, 
  const arma::cube& beta, const arma::vec& ll, arma::mat& coef, const arma::mat& X, 
  const Rcpp::IntegerVector cumsumstate, const Rcpp::IntegerVector numberOfStates, int trace);

arma::vec log_gCoef(const arma::icube& obs, const arma::cube& beta, const arma::cube& emission, const arma::mat& initk,
  const arma::mat& weights, const arma::vec& ll, const arma::mat& X, const Rcpp::IntegerVector cumsumstate, 
  const Rcpp::IntegerVector numberOfStates);

void log_internalBackward_single(const arma::mat& transition, const arma::cube& emission,
  const arma::icube& obs, arma::mat& beta, int k);

void log_internalForwardx_single(const arma::mat& transition, const arma::cube& emission,
  const arma::vec& init, const arma::icube& obs, arma::mat& alpha, int k); 

#endif
