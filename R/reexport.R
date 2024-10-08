# reexport from grid:

#' @importFrom grid gpar
#' @export
grid::gpar

#' @importFrom grid grid.text
#' @export
grid::grid.text



# reexport from lattice:

#' @importFrom lattice lpolygon
#' @export
lattice::lpolygon

#' @importFrom lattice xyplot
#' @export
lattice::xyplot



# reexport from latticeExtra:

#' @importFrom latticeExtra layer
#' @export
latticeExtra::layer

# reexport from rasterVis:

#' @importFrom rasterVis levelplot
#' @export
rasterVis::levelplot

#' @importFrom rasterVis RdBuTheme
#' @export
rasterVis::RdBuTheme

# reexport from spaMM:

#' @importFrom spaMM get_ranPars
#' @export
spaMM::get_ranPars


# reexport from terra:

#' @importFrom terra plot
#' @export
terra::plot

#' @importFrom terra points
#' @export
terra::points

#' @importFrom terra polys
#' @export
terra::polys

#' @importFrom terra rast
#' @export
terra::rast

#' @importFrom terra vect
#' @export
terra::vect

#' @importFrom terra extract
#' @export
terra::extract

#' @importFrom terra crs
#' @export
terra::crs

#' @importFrom terra "crs<-"
#' @export
terra::"crs<-"

#' @importFrom terra ext
#' @export
terra::ext

#' @importFrom terra "ext<-"
#' @export
terra::"ext<-"

#' @importFrom terra shift
#' @export
terra::shift

#' @importFrom terra values
#' @export
terra::values

#' @importFrom terra cellSize
#' @export
terra::cellSize


# Imports not reexported --------------------------------------------------

#' @importFrom terra saveRDS
#' @export
NULL # to not shadow IsoriX doc

#' @importFrom terra readRDS
#' @export
NULL # to not shadow IsoriX doc
