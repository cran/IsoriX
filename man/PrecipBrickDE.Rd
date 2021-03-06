% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IsoriX-dataset.R
\docType{data}
\name{PrecipBrickDE}
\alias{PrecipBrickDE}
\title{The precipitation monthly amounts for Germany}
\format{
A \var{RasterBrick}
}
\source{
\url{https://www.worldclim.org/data/worldclim21.html}
}
\description{
This brick of rasters contains the monthly precipitation amounts (in mm) for
Germany with a resolution of approximately 30 square-km.
}
\details{
The data are derived from "precipitation (mm) WorldClim Version2" which can
be downloaded using the function \code{\link{getprecip}}.
}
\examples{

## The following example requires to download
## a large precipitation rasters with the function getprecip()
## and will therefore not run unless you uncomment it

## How did we create this file?

## Uncomment the following to create the file as we did
#getprecip() ## Download the tif files (~ 1 Gb compressed)
#PrecipBrickDE <- prepcipitate(raster = ElevRasterDE)
#save(PrecipBrickDE, file = "PrecipBrickDE", compress = "xz")

}
\seealso{
\code{\link{prepcipitate}} to prepare this raster
}
\keyword{datasets}
