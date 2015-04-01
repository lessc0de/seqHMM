% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/ssp.R
\name{ssp}
\alias{ssp}
\title{Define Arguments for Plotting Multichannel Sequences and/or Most Probable
Paths from Hidden Markov Models}
\usage{
ssp(x, mpp = NULL, plots = "obs", type = "I", sortv = NULL,
  sort.channel = 1, dist.method = "OM", with.missing = FALSE,
  title = NA, title.n = TRUE, cex.title = 1, title.pos = 1,
  withlegend = "auto", ncol.legend = "auto", with.missing.legend = "auto",
  legend.prop = 0.3, cex.legend = 1, mpp.color = "auto",
  mpp.labels = "auto", xaxis = TRUE, xlab = NA, xtlab = NULL,
  xlab.pos = 1, ylab = "auto", hiddenStates.title = "Hidden states",
  ylab.pos = "auto", cex.lab = 1, cex.axis = 1, ...)
}
\arguments{
\item{x}{Either hidden Markov model object of class \code{HMModel} or a
  sequence object created with the \code{\link{seqdef}} function or a list of
  sequence objects.}

\item{mpp}{Output from \code{\link{mostProbablePath}} function. Optional, if
  \code{x} is a HMModel object or if \code{type=="obs"}.}

\item{plots}{What to plot (one of \code{"obs"} for observations, \code{"mpp"}
  for most probable paths (Viterbi paths), or \code{"both"} for observations
  and most probable paths).}

\item{type}{The type of the plot. Available types are \code{"I"} for index
  plots and \code{"d"} for state distribution plots. See
  \code{\link{seqplot}} for details.}

\item{sortv}{A sorting variable or a sort method (one of \code{"from.start"},
  \code{"from.end"}, \code{"mds.obs"}, or \code{"mds.mpp"}) for
  \code{type=="I"}. The value \code{"mds.mpp"} is only available for
  \code{which="both"} and \code{which="mpp"}. Options \code{"mds.obs"} and
  \code{"mds.mpp"} automatically arrange the sequences according to the
  scores of multidimensional scaling (using \code{\link{cmdscale}}) for the
  observed or hidden states path data from \code{\link{mostProbablePath}}.
  MDS scores are computed from distances/dissimilarities using a metric
  defined in argument \code{dist.method}. See \code{\link{plot.stslist}} for
  more details on \code{"from.start"} and \code{"from.end"}.}

\item{sort.channel}{The number of the channel according to which the
  \code{"from.start"} or \code{"from.end"} sorting is done. Sorting according
  to hidden states is called with value 0. The default value is 1 (the first
  channel).}

\item{dist.method}{The metric to be used for computing the distances of the
  sequences if multidimensional scaling is used for sorting. One of "OM"
  (optimal Matching, the default), "LCP" (longest common prefix), "RLCP"
  (reversed LCP, i.e. longest common suffix), "LCS" (longest common
  subsequence), "HAM" (Hamming distance), "DHD" (dynamic Hamming distance).
  Transition rates are used for defining substitution costs if needed. See
  \code{\link{seqdef}} for more information on the metrics.}

\item{with.missing}{Controls whether missing states are included in state
  distribution plots (\code{type="d"}). The default is \code{FALSE}.}

\item{title}{Title for the graphic. The default is \code{NA}: if
  \code{title.n=TRUE}, only the number of subjects is plotted. \code{FALSE}
  prints no title, even when \code{title.n=TRUE}.}

\item{title.n}{Controls whether the number of subjects is printed in the
  title of the plot. The default is \code{TRUE}: n is plotted if \code{title}
  is anything but \code{FALSE}.}

\item{cex.title}{Expansion factor for setting the size of the font for the
  title. The default value is 1. Values lesser than 1 will reduce the size of
  the font, values greater than 1 will increase the size.}

\item{title.pos}{Controls the position of the main title of the plot. The
  default value is 1. Values greater than 1 will place the title higher.}

\item{withlegend}{Defines if and where the legend for the states is plotted.
  The default value \code{"auto"} (equivalent to \code{TRUE} and
  \code{right.many}) creates separate legends for each requested plot and
  sets the positions automatically. Other possible values are \code{"right"},
  \code{"bottom"} and \code{"bottom.many"}, of which the first two create a
  combined legend in the selected position and the last one creates separate
  legends for each requested plot at the bottom of the graph. Value
  \code{FALSE} prints no legend.}

\item{ncol.legend}{(A vector of) the number of columns for the legend(s). The
  default \code{"auto"} creates one column for each legend.}

\item{with.missing.legend}{If set to \code{"auto"} (the default), a legend
  for the missing state is added automatically if one or more of the
  sequences in the data/channel contains missing states and \code{type="I"}.
  If \code{type="d"} missing states are omitted from the legends unless
  \code{with.missing=TRUE}. With the value \code{TRUE} a
  legend for the missing state is added in any case; equivalently
  \code{FALSE} omits the legend for the missing state.}

\item{legend.prop}{Sets the proportion of the graphic area used for plotting
  the legend when \code{withlegend} is not \code{FALSE}. The default value is
  0.3. Takes values from 0 to 1.}

\item{cex.legend}{Expansion factor for setting the size of the font for the
  labels in the legend. The default value is 1. Values lesser than 1 will
  reduce the size of the font, values greater than 1 will increase the size.}

\item{mpp.color}{A vector of colors assigned to hidden states. The default
  value \code{"auto"} uses the colors assigned to the stslist object created
  with \code{seqdef} if \code{mpp} is given; otherwise gray scale colors are
  automatically created according to the number of hidden states.}

\item{mpp.labels}{Labels for the hidden states. The default value
  \code{"auto"} uses the names provided in \code{x$stateNames} if \code{x} is
  an HMModel object; otherwise the number of the channel.}

\item{xaxis}{Controls whether an x-axis is plotted below the plot at the
  bottom. The default value is \code{TRUE}.}

\item{xlab}{An optional label for the x-axis. If set to \code{NA}, no label
  is drawn.}

\item{xtlab}{Optional labels for the x-axis tick labels.  If unspecified, the
  column names of the \code{seqdata} sequence object are used (see
  \code{\link{seqdef}}).}

\item{xlab.pos}{Controls the position of the x axis label. The default value
  is 1. Values greater to 1 will place the label further away from the plot.}

\item{ylab}{Labels for the channels. A vector of names for each channel
  (observations). The default value \code{"auto"} uses the names provided in
  \code{x$channelNames} if \code{x} is an HMModel object; otherwise the
  number of the channel. \code{FALSE} prints no labels.}

\item{hiddenStates.title}{Optional label for the hidden state plot (in the
  y-axis). The default is \code{"Hidden states"}.}

\item{ylab.pos}{Controls the position of the y axis labels (labels for
  channels and/or hidden states). Either \code{"auto"} or a numerical vector
  indicating on how far away from the plots the titles are positioned. The
  default value \code{"auto"} positions all titles on line 1.}

\item{cex.lab}{Expansion factor for setting the size of the font for the axis
  labels. The default value is 1. Values lesser than 1 will reduce the size
  of the font, values greater than 1 will increase the size.}

\item{cex.axis}{Expansion factor for setting the size of the font for the
  axis. The default value is 1. Values lesser than 1 will reduce the size of
  the font, values greater than 1 will increase the size.}

\item{...}{Other arguments to be passed to \code{\link{seqplot}} to produce
  the appropriate plot method.}
}
\value{
Object of class \code{ssp}.
}
\description{
Function \code{ssp} defines the arguments for plotting with
\code{\link{ssplot}} or \code{\link{gridplot}}.
}
\examples{
require(TraMineR)

data(biofam)
biofam <- biofam[1:500,]

## Building one channel per type of event left, children or married
bf <- as.matrix(biofam[, 10:25])
children <-  bf==4 | bf==5 | bf==6
married <- bf == 2 | bf== 3 | bf==6
left <- bf==1 | bf==3 | bf==5 | bf==6

children[children==TRUE] <- "Children"
children[children==FALSE] <- "Childless"

married[married==TRUE] <- "Married"
married[married==FALSE] <- "Single"

left[left==TRUE] <- "Left home"
left[left==FALSE] <- "With parents"

## Building sequence objects
child.seq <- seqdef(children)
marr.seq <- seqdef(married)
left.seq <- seqdef(left)

## Choosing colors
attr(child.seq, "cpal") <- c("#66C2A5", "#FC8D62")
attr(marr.seq, "cpal") <- c("#E7298A", "#E6AB02")
attr(left.seq, "cpal") <- c("#A6CEE3", "#E31A1C")


# Defining the plot for state distribution plots of observations
ssp1 <- ssp(list(child.seq, marr.seq, left.seq), type="d", plots="obs")
# Plotting ssp1
plot(ssp1)

# Defining the plot for sequence index plots of observations
ssp2 <- ssp(list(child.seq, marr.seq, left.seq), type="I", plots="obs",
# Sorting subjects according to the beginning of the 2nd channel (marr.seq)
sortv="from.start", sort.channel=2,
# Controlling the size, positions, and names for channel labels
ylab.pos=c(1,2,1), cex.lab=1, ylab=c("Children", "Married", "Left home"),
# Plotting without legend
withlegend=FALSE)
# Plotting previously defined plot ssp2
plot(ssp2)

# Computing hidden Markov model

# Initial values for emission matrices
B_child <- matrix(NA, nrow=3, ncol=2)
B_child[1,] <- seqstatf(child.seq[,1:5])[,2]+0.1
B_child[2,] <- seqstatf(child.seq[,6:10])[,2]+0.1
B_child[3,] <- seqstatf(child.seq[,11:15])[,2]+0.1
B_child <- B_child/rowSums(B_child)

B_marr <- matrix(NA, nrow=3, ncol=2)
B_marr[1,] <- seqstatf(marr.seq[,1:5])[,2]+0.1
B_marr[2,] <- seqstatf(marr.seq[,6:10])[,2]+0.1
B_marr[3,] <- seqstatf(marr.seq[,11:15])[,2]+0.1
B_marr <- B_marr/rowSums(B_marr)

B_left <- matrix(NA, nrow=3, ncol=2)
B_left[1,] <- seqstatf(left.seq[,1:5])[,2]+0.1
B_left[2,] <- seqstatf(left.seq[,6:10])[,2]+0.1
B_left[3,] <- seqstatf(left.seq[,11:15])[,2]+0.1
B_left <- B_left/rowSums(B_left)

# Initial values for transition matrix
A <- matrix(c(0.9, 0.07, 0.03,
0,    0.9,  0.1,
0,      0,    1),
nrow=3, ncol=3, byrow=TRUE)

# Initial values for initial state probabilities
initialProbs <- c(0.9,0.09,0.01)

# Building hidden Markov model with initial parameter values
bHMM <- buildHMM(observations=list(child.seq, marr.seq, left.seq),
transitionMatrix=A,
emissionMatrix=list(B_child, B_marr, B_left),
initialProbs=initialProbs)

# Fitting hidden Markov model
HMM <- fitHMM(bHMM, em.control=list(maxit=100,reltol=1e-8),
itnmax=10000, method="BFGS")

# Plotting observations and hidden states (most probable) paths
ssp3 <- ssp(HMM$model, type="I", plots="both",
# Sorting according to multidimensional scaling of hidden states paths
sortv="mds.mpp",
ylab=c("Children", "Married", "Left home"),
# Controlling title
title="Biofam", cex.title=1.5,
# Labels for x axis and tick marks
xtlab=15:30, xlab="Age")
plot(ssp3)

# Computing the most probable paths
mpp <- mostProbablePath(HMM$model)$mpp
mpp.seq <- seqdef(mpp, labels=c("Hidden state 1", "Hidden state 2", "Hidden state 3"))

# Plotting observations and hidden state paths
ssp4 <- ssp(HMM$model, type="I", plots="mpp",
             # Sequence object of most probable paths
             mpp=mpp.seq,
             # Sorting according to the end of hidden state paths
sortv="from.end", sort.channel=0,
# Contolling legend position, type, and proportion
withlegend="bottom", legend.prop=0.15,
# Plotting without title and y label
title=FALSE, ylab=FALSE)
plot(ssp4)
}
\seealso{
\code{\link{plot.ssp}} for plotting objects created with
  \code{ssp}, \code{\link{gridplot}} for plotting multiple ssp
  objects, \code{\link{buildHMM}} and \code{\link{fitHMM}} for building and
  fitting Hidden Markov models, and \code{\link{mostProbablePath}} for
  computing the most probable paths (Viterbi paths) of hidden states.
}
