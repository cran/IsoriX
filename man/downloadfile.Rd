% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getelev.R
\name{downloadfile}
\alias{downloadfile}
\title{Download files and check their binary integrity}
\usage{
downloadfile(
  address = NULL,
  filename = NULL,
  path = NULL,
  overwrite = FALSE,
  md5sum = NULL,
  verbose = interactive()
)
}
\arguments{
\item{address}{A \emph{string} indicating the address of the file on internet}

\item{filename}{A \emph{string} indicating the name under which the file must
be stored}

\item{path}{A \emph{string} indicating where to store the file on the hard
drive (without the file name!). Default = current directory.}

\item{overwrite}{A \emph{logical} indicating if an existing file should be
re-downloaded}

\item{md5sum}{A \emph{string} indicating the md5 signature of the valid file
as created with \code{\link[tools:md5sum]{tools::md5sum}}}

\item{verbose}{A \emph{logical} indicating whether information about the
progress of the procedure should be displayed or not while the function is
running. By default verbose is \code{TRUE} if users use an interactive R
session and \code{FALSE} otherwise. If a \emph{numeric} is provided instead,
additional information about the download will be provided if the number is
greater than 1.}
}
\value{
The complete path of the downloaded file (invisibly)
}
\description{
This function is the internal function used in IsoriX to download the large
files from internet and it could be useful to download anything from within
R. We created this function to make sure that the downloaded files are valid.
Downloads can indeed result in files that are corrupted, so we tweaked the
options to reduce this possibility and the function runs a check if the
signature of the file is provided to the argument \code{md5sum}.
}
\note{
Users should directly use the function \code{\link{getelev}} and
\code{\link{getprecip}}.
}
\seealso{
\code{\link{getelev}}, \code{\link{getprecip}}
}
