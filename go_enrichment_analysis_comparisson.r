#!/usr/bin/env Rscript

#' This script will take two GO enrichement analyses by Ontologizer 2.0 and plot the change in rank
#' Author: John van Dam, teunis.j.p.vandam@gmail.com
#' Date: January 17th 2017
#' 

top.n.rank = 30  # top "n" of ranked list

# Get arguments from command line so that I can use this script in a makefile
library("optparse")

option_list <- list(
  make_option(c("-a","--file_a"), type="character", default=NULL, help="File 'A' to be compared.", metavar="character"),
  make_option(c("-b","--file_b"), type="character", default=NULL, help="File 'B' to be compared.", metavar="character"),
  make_option(c("-n","--top_n"), type="integer", default=30, help="Number of top rankings to consider", metavar="integer")
)
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

top.n.rank = opt$top_n  # top "n" of ranked list

if (is.null(opt$file_a) || is.null(opt$file_b)){
  print_help(opt_parser)
  stop("Please provide both 'A' and 'B' file names.n", call.=FALSE)
}

pdf(file=paste0(opt$file_a, "-", opt$file_b, ".pdf"))

# Load gene enrichement with different GO versions and/or with same or different gene annotations
setA <- read.delim(opt$file_a)
setB <- read.delim(opt$file_b)

# Take only top ranking genes
setA <- setA[0:top.n.rank, ]
setB <- setB[0:top.n.rank, ]

# We need to reverse the order of the list in order to get the first one at the top in the plot
setA <- setA[rev(rownames(setA)), ]
setB <- setB[rev(rownames(setB)), ]

set.par <- par(mar=c(8,0,7,0))

# Plot two columns of equidistant points
labels.offset <- 0.1
arrow.len <- 0.1
plot(rep(1, top.n.rank), 1:top.n.rank, pch=0, cex=1.2, 
     xlim=c(0, 3), ylim=c(0, max(top.n.rank, top.n.rank)),
     axes=F, xlab="GO version", ylab="") # Remove axes and labels
points(rep(2, top.n.rank), 1:top.n.rank, pch=0, cex=1.2)

# Put labels next to each observation
text(rep(1-labels.offset, top.n.rank), 1:top.n.rank, labels=paste(setA$name,format(setA$p.adjusted, digits=2),sep=" "), pos=2, cex=0.7)
#  text(rep(2+labels.offset, len.2), 1:len.2, b)
text(rep(2+labels.offset, top.n.rank), 1:top.n.rank, labels=paste(format(setB$p.adjusted, digits=2),setB$name,sep=" "), pos=4, cex=0.7)
text(1:2,c(0,0,0),labels=c("2012-12-01","2016-10-18"), pos=1)

# Now we need to map where the elements of a are in b
# We use the match function for this job
a.to.b <- match(setA$ID, setB$ID)

# Now we can draw arrows from the first column to the second
arrows(rep(1.32, top.n.rank), 1:top.n.rank, rep(1.68, top.n.rank), a.to.b, 
       length=arrow.len, angle=20)

# Done!

