#' Plotting functions for IsoriX
#'
#' These functions plot objects created by IsoriX (with the exception of plot
#' method for SpatRaster created using [`terra::terra`]. All plotting functions
#' are based on the powerful package \pkg{lattice}. If instead you want to
#' use \pkg{ggplot2}, please follow the instructions on the
#' [online tutorial](https://bookdown.org/content/782/advanced.html#ggplot).
#'
#'
#' **General**
#'
#' When called upon an object of class *ISOFIT*, the plot function
#' draws diagnostic information for the fits of the isoscape geostatistical
#' model.
#'
#' When called upon an object of class *CALIBFIT*, the plot function draws the
#' fitted calibration function.
#'
#' When called upon an object of class *ISOSCAPE*, the plot function draws a
#' fine-tuned plot of the isoscape.
#'
#' When called upon an object of class *SpatRaster*, the plot function displays
#' the raster (just for checking things fast and dirty). In this case, the
#' function is a simple shortcut to [`rasterVis::levelplot`].
#'
#'
#' **Plotting isoscapes**
#'
#' When used on a fitted isoscape, the user can choose between plotting the
#' predictions (`which = "mean"`; default), the prediction variance (`which =
#' "mean_predVar"`), the residual variance (`which = "mean_residVar"`), or the
#' response variance (`which = "mean_respVar"`) for the mean model; or the
#' corresponding information for the residual dispersion variance model
#' (`"disp"`, `"disp_predVar"`, `"disp_residVar"`, or `"disp_respVar"`).
#'
#' When used on a simulated isoscape produced with the function `isosim`
#' (currently dropped due to the package RandomFields being temporarily retired
#' from CRAN), the user can choose between plotting the mean isotopic value
#' (`which = "mean"`) or the residual dispersion (`which = "disp"`).
#'
#'
#' **Plotting assignments**
#'
#' When called upon an object of class *ISOFIND*, the plot function draws a
#' fine-tuned plot of the assignment. You can use the argument `who` to choose
#' between plotting the assignment for the group or for some individuals (check
#' the [online tutorial](https://bookdown.org/content/782/) for examples).
#'
#'
#' **Info on parameters influencing the rendering of maps**
#'
#' The argument `y_title` is a list that can be tweaked to customise the title
#' of isoscapes. Within this list, the element `which` is a logical indicating
#' if the name of the layer should be displayed or not. The element `title` is a
#' string or a call used to define the rest of the title. By default it draws
#' the delta value for hydrogen. Check the syntax of this default before trying
#' to modify it. If you want to modify it for all plots, see [`getOption_IsoriX`].
#'
#' The arguments `cutoff`, `sources`, `calibs`, `assigns`, `borders`, `mask`,
#' and `mask2` are used to fine-tune additional layers that can be added to the
#' main plot to embellish it. These arguments must be lists that provide details
#' on how to draw, respectively, the area outside the prediction interval (for
#' assignment plots), the locations of sources (for both isoscape and assignment
#' plots), the locations of the calibration samples (for assignment plots), the
#' locations of the assignment samples (for assignment plots), the borders (for
#' both types of plots), and the mask (again, for both). For assignment maps, an
#' extra mask can be used (mask2), as one may want to add a mask covering the
#' area outside the biological range of the species. Within these lists, the
#' elements `lwd`, `col`, `cex`, `pch` and `fill` influences their respective
#' objects as in traditional R plotting functions (see [`par`] for details). The
#' element `draw` should be a *logical* that indicates whether the layer must be
#' created or not. The argument `borders` (within the list borders) expects an
#' object of the class *SpatVector*, such as the object [`CountryBorders`]
#' provided with this package. The argument `mask` (within the list mask)
#' also expects an object of the class *SpatVector*, such as the object
#' [`OceanMask`] provided with this package (see examples).
#'
#' The argument `palette` is used to define how to colour the isoscape and
#' assignment plot. Within this list, `step` defines the number of units on the
#' z-scale that shares a given colour; `range` can be used to constrain the
#' minimum and/or maximum values to be drawn (e.g. range = c(0, 1)) (this latter
#' argument is useful if one wants to create several plots with the same
#' z-scale); `n_labels` allows for the user to approximately define the
#' maximum number of numbers plotted on the z-scale; `digits` defines the number
#' of digits displayed for the numbers used as labels; and `fn` is used to
#' specify the function that is used to sample the colours. If `fn` is NULL
#' (default) the palette functions derived from [`isopalette1`] and [`isopalette2`]
#' are used when plotting isoscape and assignments, respectively. If `fn` is NA
#' the function used is the palette [`viridisLite::viridis`].
#'
#' **Default symbols used on maps**
#'
#' Under the default settings, we chose to
#' represent:
#'    - the source data by little red triangles.
#'    - the calibration data by little blue crosses.
#'    - the locations where the samples to assign were collected by white
#'    diamonds.
#'
#' These symbols can be changed as explained above.
#'
#' @name plots
#' @aliases plot.ISOFIT plot.ISOSCAPE plot.CALIBFIT plot.ISOFIND
#'   plot.SpatRaster
#' @param x The return object of a call to [`isofit`], [`isoscape`], [`calibfit`],
#'   [`isofind`], or [`terra::rast`]
#' @param cex_scale A *numeric* giving a scaling factor for the points in
#'   the plots
#' @param which A *string* indicating the name of the raster to be plotted
#'   (see details)
#' @param y_title A *list* containing information for the display of the
#'   title (see details)
#' @param who Either "group", or a vector of indices (e.g. 1:3) or names of the
#'   individuals (e.g. c("Mbe_1", "Mbe_3")) to be considered in assignment plots
#' @param cutoff A *list* containing information for the display of the
#'   region outside the prediction interval (see details)
#' @param sources A *list* containing information for the display of the
#'   location of the sources (see details)
#' @param calibs A *list* containing information for the display of the
#'   location of the calibration sampling location (see details)
#' @param assigns A *list* containing information for the display of the
#'   location of the assignment sampling location (see details)
#' @param borders A *list* containing information for the display of borders
#'   (e.g. country borders) (see details)
#' @param mask A *list* containing information for the display of a mask
#'   (e.g. an ocean mask) (see details)
#' @param mask2 A *list* containing information for the display of a mask
#'   (e.g. a distribution mask) (see details)
#' @param palette A *list* containing information for the display of the
#'   colours for the isoscape (see details)
#' @param plot A *logical* indicating whether the plot shall be plotted or
#'   just returned
#' @param sphere A *list* containing information whether the raster should
#'   be returned as a rotating sphere and if the image created during the
#'   process should be saved in your current working directory. The default
#'   settings are FALSE and TRUE, respectively.
#'
#' @param xlab A *string* the x-axis label in plot.CALIBFIT
#' @param ylab A *string* the y-axis label in plot.CALIBFIT
#' @param xlim A range defining the extreme coordinates for the the x-axis in
#'   plot.CALIBFIT
#' @param ylim A range defining the extreme coordinates for the the y-axis in
#'   plot.CALIBFIT
#' @param pch The argument pch as in [`par`] for plot.CALIBFIT and
#'   points.CALIBFIT
#' @param col The argument col as in [`par`] for plot.CALIBFIT and
#'   points.CALIBFIT
#' @param line A *list* containing two elements: `show`, a
#'   *logical* indicating whether to show the regression line or not; and
#'   `col`, a *string* or *integer* indicating the colour for
#'   plotting the regression line
#' @param CI A *list* containing two elements: `show`, a *logical*
#'   indicating whether to show the confidence interval or not; and `col`,
#'   a *string* or *integer* indicating the colour for plotting the
#'   confidence interval
#' @param ... Additional arguments (only in use in plot.CALIBFIT and
#'   plot.SpatRaster)
#'
#' @seealso [`isofit`] for the function fitting the isoscape
#'
#'   [`isoscape`] for the function building the isoscape
#'
#'   [`calibfit`] for the function fitting the calibration function
#'
#'   [`isofind`] for the function performing the assignment
#'
#' @keywords plot
#' @examples ## See ?isoscape or ?isofind for examples
#'
NULL

#' @rdname plots
#' @method plot ISOSCAPE
#' @exportS3Method plot ISOSCAPE
plot.ISOSCAPE <- function(x,
                          which = "mean",
                          y_title = list(which = TRUE, title = getOption_IsoriX("title_delta_notation")),
                          sources = list(draw = TRUE, cex = 0.5, pch = 2, lwd = 1, col = "red"),
                          borders = list(borders = NA, lwd = 0.5, col = "black"),
                          mask = list(mask = NA, lwd = 0, col = "black", fill = "black"),
                          palette = list(step = NA, range = c(NA, NA), n_labels = 11, digits = 2, fn = NA),
                          plot = TRUE,
                          sphere = list(build = FALSE, keep_image = TRUE),
                          ... ## we cannot remove the dots because of the S3 export...
) {
  if (!inherits(x, "ISOSCAPE")) {
    stop("This function must be called on an object of class ISOSCAPE.")
  }

  simu <- "ISOSIM" %in% class(x)

  ## complete input with default setting
  .complete_args(plot.ISOSCAPE)

  ## importing palette if missing
  if (!is.null(palette$fn) && !is.function(palette$fn) && is.na(palette$fn)) {
    isopalette1 <- NULL ## to please R CMD check
    utils::data("isopalette1", envir = environment(), package = "IsoriX")
    palette$fn <- grDevices::colorRampPalette(isopalette1, bias = 1)
  }

  ## importing country borders if missing
  if (!is.null(borders$borders) && is.na(borders$borders)) {
    borders$borders <- terra::readRDS(system.file("extdata/CountryBorders.rds", package = "IsoriX"))
  }

  ## importing ocean if missing
  if (!is.null(mask$mask) && !inherits(mask$mask, "SpatVector") && is.na(mask$mask)) {
    mask$mask <- terra::readRDS(system.file("extdata/OceanMask.rds", package = "IsoriX"))
  }

  if (simu) {
    if (sources$draw) {
      sources$draw <- FALSE
      message("You have asked to plot sources, but it does not make sense for simulations as each raster cell is a source. The argument 'plot.sources' was thus considered to be FALSE.")
    }
    if (!(which %in% c("mean", "disp"))) {
      stop("For simulated data, the argument 'which' must be 'mean' or 'disp'.")
    }
  } else {
    if (!(which %in% c(
      "mean", "mean_predVar", "mean_residVar", "mean_respVar",
      "disp", "disp_predVar", "disp_residVar", "disp_respVar"
    ))) {
      stop("argument 'which' unknown")
    }
  }

  ## compute the colors
  colours <- .cut_and_color(
    var = x$isoscapes[[which]], # @data@values,
    step = palette$step,
    range = palette$range,
    palette = palette$fn,
    n_labels = palette$n_labels,
    digits = palette$digits
  )

  ## define y title
  Title <- ""
  if (simu) Title <- "simulated"
  if (y_title$which) Title <- paste(Title, sub("_", " ", which, fixed = TRUE))
  if (!is.null(y_title$title)) Title <- bquote(.(Title) ~ .(y_title$title))

  ## create the levelplot
  ##  note the use of bquote() which contrary to expression(paste())
  ##  allows for the evaluation of arguments.
  ##  (the stars are used to remove spaces)

  map <- rasterVis::levelplot(x$isoscapes[[which]],
    maxpixels = prod(dim(x$isoscapes[[which]])[1:2]),
    margin = FALSE,
    col.regions = colours$all_cols,
    at = colours$at,
    colorkey = list(labels = list(at = colours$at_keys, labels = colours$at_labels)),
    main = Title
  )

  ## create the additional plot(s)
  decor <- .build_additional_layers(
    x = x,
    sources = sources,
    calibs = NULL,
    borders = borders,
    mask = mask
  )


  complete_map <- map + decor$borders_layer + decor$mask_layer + decor$sources_layer

  ## plotting
  if (plot && !sphere$build) {
    ## check if prompt must appear in examples
    if (.data_IsoriX$IsoriX_options$dont_ask) {
      options(example_ask = "FALSE") ## only effective for the next example run, not the current one...
    }
    ## send plot to graphic device
    print(complete_map)
  }

  ## tweak to please codetools::checkUsagePackage('IsoriX', skipWith = TRUE)
  rm(Title)

  ## build the 3D-Sphere
  if (sphere$build) {
    .build_sphere(x$isoscapes[[which]], colours = colours, decor = decor)
    if (!sphere$keep_image) {
      message(paste(
        "IsoriX no longer delete the image used to build the sphere since it prevents rgl to work on some system. \n",
        "You can always delete manually the file created which is stored here: \n",
        normalizePath(file.path("IsoriX_world_image.png"))
      ))
      # file.remove("IsoriX_world_image.png")
    }
    message("If you do not see the sphere, run rgl::rglwidget()")
  }

  return(invisible(complete_map))
}

.build_sphere <- function(x, colours, decor) {
  ## we are indebted to Deepayan Sarkar for helping use with the following lattice code
  if (!requireNamespace("rgl", quietly = TRUE)) {
    stop("The package 'rgl' is needed for this function,
    you can install it by typing install.packages('rgl').")
  }

  if (interactive()) {
    print("Building the sphere...", quote = FALSE)
    print("(this may take a few seconds)", quote = FALSE)
  }
  ### check extent of the raster and extend to world if necessary
  world_raster <- terra::rast()
  if (terra::ext(x) < terra::ext(world_raster)) {
    terra::ext(x) <- terra::ext(world_raster)
  }
  p <- rasterVis::levelplot(x,
    col.regions = colours$all_cols,
    at = colours$at,
    colorkey = FALSE,
    maxpixels = prod(dim(x)[1:2])
  ) + decor$borders_layer +
    decor$mask_layer + decor$mask2_layer + decor$sources_layer + decor$calibs_layer
  grDevices::png(filename = "IsoriX_world_image.png", width = 2 * dim(x)[2], height = 2 * dim(x)[1])
  print(p)
  pargs <- lattice::trellis.panelArgs(p, 1)
  lims <- do.call(lattice::prepanel.default.levelplot, pargs)

  grid::grid.newpage()
  grid::pushViewport(grid::viewport(
    xscale = grDevices::extendrange(lims$xlim, f = 0.07),
    yscale = grDevices::extendrange(lims$ylim, f = 0.07)
  ))
  do.call(p$panel, pargs)
  grDevices::dev.off()

  while (length(rgl::rgl.dev.list()) > 0) rgl::close3d() ## close all open rgl devices
  makerglsphere <- function(x, y = NULL, z = NULL, ng = 50, radius = 1, color = "white", add = FALSE, ...) {
    ## code inspired from https://stackoverflow.com/questions/30627647/how-to-plot-a-perfectly-round-sphere-in-r-rgl-spheres
    lat <- matrix(seq(90, -90, length.out = ng) * pi / 180, ng, ng, byrow = TRUE)
    long <- matrix(seq(-180, 180, length.out = ng) * pi / 180, ng, ng)
    xyz <- grDevices::xyz.coords(x, y, z, recycle = TRUE)
    vertex <- matrix(rbind(xyz$x, xyz$y, xyz$z), nrow = 3, dimnames = list(c("x", "y", "z"), NULL))
    nvertex <- ncol(vertex)
    radius <- rbind(vertex, rep(radius, length.out = nvertex))[4, ]
    color <- rbind(vertex, rep(color, length.out = nvertex))[4, ]

    for (i in 1:nvertex) {
      add2 <- if (!add) i > 1 else TRUE
      x <- vertex[1, i] + radius[i] * cos(lat) * cos(long)
      y <- vertex[2, i] + radius[i] * cos(lat) * sin(long)
      z <- vertex[3, i] + radius[i] * sin(lat)
      rgl::persp3d(x, y, z,
        add = add2, color = color[i], axes = FALSE,
        xlab = "", ylab = "", zlab = "", ...
      )
    }
  }

  rgl::par3d("windowRect" = c(0, 0, 500, 500))
  rgl::bg3d(sphere = TRUE, color = "darkgrey", lit = FALSE)
  makerglsphere(0, texture = "IsoriX_world_image.png", lit = FALSE, color = "white") ## alternative to rgl::spheres3d()
}

#' @rdname plots
#' @method plot ISOFIND
#' @exportS3Method plot ISOFIND
plot.ISOFIND <- function(x,
                         who = "group",
                         cutoff = list(draw = TRUE, level = 0.05, col = "#909090"),
                         sources = list(draw = TRUE, cex = 0.5, pch = 2, lwd = 1, col = "red"),
                         calibs = list(draw = TRUE, cex = 0.5, pch = 4, lwd = 1, col = "blue"),
                         assigns = list(draw = TRUE, cex = 0.5, pch = 5, lwd = 1, col = "white"),
                         borders = list(borders = NA, lwd = 0.5, col = "black"),
                         mask = list(mask = NA, lwd = 0, col = "black", fill = "black"),
                         mask2 = list(mask = NA, lwd = 0, col = "purple", fill = "purple"),
                         palette = list(step = NA, range = c(0, 1), n_labels = 11, digits = 2, fn = NA),
                         plot = TRUE,
                         sphere = list(build = FALSE, keep_image = TRUE),
                         ... ## we cannot remove the dots because of the S3 export...
) {
  what <- "pv" ## ToDo: implement other possibilities

  if (!inherits(x, "ISOFIND")) {
    stop("This function must be called on an object of class ISOFIND")
  }

  ## complete input with default setting
  .complete_args(plot.ISOFIND)

  ## importing palette if missing
  if (!is.null(palette$fn) && !is.function(palette$fn) && is.na(palette$fn)) {
    isopalette2 <- NULL ## to please R CMD check
    utils::data("isopalette2", envir = environment(), package = "IsoriX")
    palette$fn <- grDevices::colorRampPalette(isopalette2, bias = 0.75)
  }

  ## importing country borders if missing
  if (!is.null(borders$borders) && is.na(borders$borders)) {
    borders$borders <- terra::readRDS(system.file("extdata/CountryBorders.rds", package = "IsoriX"))
  }

  ## importing ocean if missing
  if (!is.null(mask$mask) && !inherits(mask$mask, "SpatVector") && is.na(mask$mask)) {
    mask$mask <- terra::readRDS(system.file("extdata/OceanMask.rds", package = "IsoriX"))
  }

  ## changing missing setting for mask2
  if (!is.null(mask2$mask) && !inherits(mask2$mask, "SpatVector") && is.na(mask2$mask)) {
    mask2$mask <- NULL
  }

  ## changing cutoff level to null when we don't want to draw the cutoff
  if (what != "pv" || !cutoff$draw) {
    cutoff$level <- 0
  }

  ## changing who when sample is size one
  if ("group" %in% who && length(names(x$sample[[what]])) == 1) {
    who <- names(x$sample[[what]])
  }

  ## create the main plot(s)
  if ("group" %in% who) {
    colours <- .cut_and_color(
      var = x$group$pv, # @data@values, removed
      step = palette$step,
      range = palette$range,
      palette = palette$fn,
      cutoff = cutoff$level,
      col_cutoff = cutoff$col,
      n_labels = palette$n_labels,
      digits = palette$digits
    )

    group_noNAs <- terra::classify(x$group$pv, cbind(NA, NA, 0))
    if (!identical(terra::values(group_noNAs), terra::values(x$group$pv))) {
      warning("The assignment test occurred at location(s) with unknown isoscape value(s); p-values set to 0 for such (a) location(s).")
    }

    map <- rasterVis::levelplot(group_noNAs, # x$group$pv * (x$group$pv > cutoff$level)
      maxpixels = prod(dim(x$group$pv)[1:2]),
      margin = FALSE,
      col.regions = colours$all_cols,
      at = colours$at,
      colorkey = list(labels = list(at = colours$at_keys, labels = colours$at_labels)),
      main = "Group assignment"
    )
  } else {
    main_title <- if (length(who) == 1) {
      names(x$sample[[what]][[who]])
    } else {
      NULL
    }

    colours <- .cut_and_color(
      var = x$sample[[what]][[who]], # @data@values removed: does not work if raster on hard drive...
      step = palette$step,
      range = palette$range,
      palette = palette$fn,
      cutoff = cutoff$level,
      col_cutoff = cutoff$col,
      n_labels = palette$n_labels,
      digits = palette$digits
    )

    stack_noNAs <- terra::classify(x$sample[[what]][[who]], cbind(NA, NA, 0))
    if (!identical(terra::values(stack_noNAs), terra::values(x$sample[[what]][[who]]))) {
      warning("The assignment test occurred at location(s) with unknown isoscape value(s); p-values set to 0 for such (a) location(s).")
    }

    map <- rasterVis::levelplot(stack_noNAs, # x$sample[[what]][[who]] * (x$sample$pv[[who]] > cutoff$level)
      maxpixels = prod(dim(stack_noNAs)[1:2]),
      margin = FALSE,
      col.regions = colours$all_cols,
      at = colours$at,
      colorkey = list(labels = list(at = colours$at_keys, labels = colours$at_labels)),
      main = main_title
    )
  }

  ## create the additional plot(s)
  decor <- .build_additional_layers(
    x = x,
    sources = sources,
    calibs = calibs,
    assigns = assigns,
    borders = borders,
    mask = mask,
    mask2 = mask2
  )

  ## changing the colour below the threshold
  if (cutoff$level > 0) {
    index <- 1:max(which(map$legend$right$args$key$at < cutoff$level))
    map$legend$right$args$key$col[index] <- cutoff$col
  }

  ## we add the legend for the side bar
  ## (thanks to Deepayan Sarkar, for solving a device opening hicup at this stage)
  map$legend$right <- list(
    fun = latticeExtra::mergedTrellisLegendGrob,
    args = list(map$legend$right,
      list(
        fun = grid::textGrob,
        args = list(label = "P-value", rot = 90)
      ),
      vertical = FALSE
    )
  )

  ## piling all layers together
  complete_map <- map + decor$borders_layer + decor$mask_layer + decor$mask2_layer +
    decor$sources_layer + decor$calibs_layer + decor$assigns_layer

  ## plotting
  if (plot && !sphere$build) {
    ## check if prompt must appear in examples
    if (.data_IsoriX$IsoriX_options$dont_ask) {
      options(example_ask = "FALSE") ## only effective for the next example run, not the current one...
    }
    ## send plot to graphic device
    print(complete_map)
  }

  ## build the 3D-Sphere
  if (sphere$build) {
    if (terra::nlyr(stack_noNAs) > 1) {
      message("You requested a sphere but you requested several assignment maps.
In this case, only the first assignment will be drawn on a sphere.
If you want to build several spheres, build them one by one and do request a single assignment each time.")
    }
    .build_sphere(stack_noNAs[[1]], colours = colours, decor = decor)
    if (!sphere$keep_image) {
      message(paste(
        "IsoriX no longer delete the image used to build the sphere since it prevents rgl to work on some system. \n",
        "You can always delete manually the file created which is stored here: \n",
        normalizePath(file.path("IsoriX_world_image.png"))
      ))
      # file.remove("IsoriX_world_image.png")
    }
  }

  return(invisible(complete_map))
}


.cut_and_color <- function(var,
                           step = NA,
                           range = NA,
                           palette = NULL,
                           cutoff = NA,
                           col_cutoff = "#909090",
                           n_labels = 99,
                           digits = 2) {
  var <- .summarize_values(var) ## converting rasters info into numerics if needed
  var <- var[!is.na(var)]
  max_var <- max(var)
  min_var <- min(var)

  if (is.na(n_labels)) {
    warning("The argument n_labels of the palette was changed to 10 because it was not defined!")
    n_labels <- 10
  }
  if (length(range) == 1) {
    range <- c(NA, NA)
  }
  if (is.na(range)[1]) {
    range[1] <- min_var
  }
  if (is.na(range)[2]) {
    hard.top <- FALSE
    range[2] <- max_var
  } else {
    hard.top <- TRUE
  }
  if (is.na(step)) {
    step <- (max(range, na.rm = TRUE) - min(range, na.rm = TRUE)) / (n_labels - 1)
  }
  where_cut <- seq(min(range, na.rm = TRUE), (max(range, na.rm = TRUE)), step)
  if ((max(where_cut) < max_var) && !hard.top) {
    where_cut <- c(where_cut, max(where_cut) + step)
    n_labels <- n_labels + 1
  }
  if ((min_var < min(where_cut)) || (max_var > max(where_cut))) {
    warning(paste0(
      "Range for palette too small! It should be at least: [",
      min_var, "-", max_var, "]"
    ))
  }
  if (!is.na(cutoff)) {
    where_cut <- sort(unique(c(cutoff, where_cut)))
  }
  if (length(unique(var)) > 1) {
    cats <- cut(var, where_cut, ordered_result = TRUE) ## also works on non raster
  } else { ## case if no variation
    cats <- as.factor(where_cut)
    where_cut <- c(where_cut, where_cut + 1e-10)
    warning("There is no variation in the map!")
  }
  if (is.null(palette)) {
    palette <- viridisLite::viridis
  }
  all_cols <- do.call(palette, list(n = length(levels(cats))))
  if (!is.na(cutoff)) {
    all_cols[1:(which(where_cut == cutoff) - 1)] <- col_cutoff
  }
  cols <- all_cols[match(cats, levels(cats))]
  at_keys <- where_cut
  if (length(at_keys) > n_labels) {
    at_keys <- seq(min(where_cut), max(where_cut), length.out = n_labels)
    if (!is.na(cutoff)) {
      at_keys <- sort(unique(c(cutoff, at_keys)))
    }
  }
  if (sum(at_keys %% 1) == 0) {
    digits <- 0
  }
  at_labels <- formatC(round(at_keys, digits = digits), digits = digits, format = "f")
  return(list(cols = cols, at = where_cut, all_cols = all_cols, at_keys = at_keys, at_labels = at_labels))
}

#' @rdname plots
#' @method plot ISOFIT
#' @exportS3Method plot ISOFIT
plot.ISOFIT <- function(x, cex_scale = 0.2, ...) {
  if (!inherits(x, "ISOFIT")) {
    stop("This function must be called on an object of class ISOFIT.")
  }

  ## Test if RStudio is in use
  RStudio <- .Platform$GUI == "RStudio"

  if (!inherits(x, "MULTIISOFIT")) {
    ## Determine number of plots in panel
    if (RStudio) {
      nplot <- 1
    } else {
      nplot <- 2 + x$info_fit$disp_model_rand$spatial +
        x$info_fit$mean_model_rand$spatial
    }

    ## Define mfrow (number of rows and column in panel)
    mfrow <- switch(as.character(nplot),
      "1" = c(1, 1),
      "2" = c(1, 2),
      "3" = c(1, 3),
      "4" = c(2, 2),
      stop("The nplot value was not anticipated.")
    )

    ## Setup the graphic device
    graphics::par(mfrow = mfrow)

    ## Plots from spaMM
    spaMM::plot.HLfit(x$mean_fit,
      "predict",
      cex = 0.1 + cex_scale * log(x$mean_fit$data$weights_mean),
      las = 1, ...
    )
    graphics::title(main = "Pred vs Obs in mean_fit")
    .hit_return()

    spaMM::plot.HLfit(x$disp_fit,
      "predict",
      cex = 0.1 + cex_scale * log(x$disp_fit$data$weights_disp),
      las = 1, ...
    )
    graphics::title(main = "Pred vs Obs in disp_fit")

    ## Plot Matern autocorrelation
    if (x$info_fit$mean_model_rand$spatial) {
      .hit_return()
      .plot_Matern(x$mean_fit, ...)
      graphics::title(main = "Autocorrelation in mean_fit")
    }

    if (x$info_fit$disp_model_rand$spatial) {
      .hit_return()
      .plot_Matern(x$disp_fit, ...)
      graphics::title(main = "Autocorrelation in disp_fit")
    }

    ## Reset the graphic device
    graphics::par(mfrow = c(1, 1))
  } else {
    for (fit in seq_along(x$multi_fits)) {
      cat("\n")
      cat(paste("##### Plots for pair of models", names(x$multi_fits)[fit]), "#####")
      cat("\n")
      .hit_return()
      Recall(x$multi_fits[[fit]])
    }
  }
  return(invisible(NULL))
}


.plot_Matern <- function(model, limit = 0.01, ...) {
  ## This function should not be called by the user.
  ## It plots the Matern autocorrelation.
  rho <- spaMM::get_ranPars(model, which = "corrPars")[[1]]$rho
  nu <- spaMM::get_ranPars(model, which = "corrPars")[[1]]$nu

  d_stop <- FALSE
  d <- 0

  while ((d < 50000) && !d_stop) {
    d <- d + 10
    m <- spaMM::MaternCorr(d = d, rho = rho, nu = nu)
    if (m < limit) d_stop <- TRUE
  }

  distances <- seq(0, d, 1)

  if (length(distances) < 30) {
    d_stop <- FALSE
    d <- 0

    while ((d < 30) && !d_stop) {
      d <- d + 1
      m <- spaMM::MaternCorr(d = d, rho = rho, nu = nu)
      if (m < limit) d_stop <- TRUE
    }

    distances <- seq(0, d, 0.1)
  }

  m <- spaMM::MaternCorr(d = distances, rho = rho, nu = nu)

  graphics::plot(m ~ distances,
    type = "l",
    las = 1,
    xlab = "Distances (km)",
    ylab = "Correlation",
    ...
  )
}



#' @rdname plots
#' @method  plot CALIBFIT
#' @exportS3Method plot CALIBFIT
plot.CALIBFIT <- function(x,
                          pch = 1,
                          col = "black",
                          xlab = "Isotopic value in the environment",
                          ylab = "Isotopic value in the calibration sample",
                          xlim = NULL,
                          ylim = NULL,
                          line = list(show = TRUE, col = "blue"),
                          CI = list(show = TRUE, col = "blue"),
                          plot = TRUE,
                          ...) {
  .complete_args(plot.CALIBFIT)

  plotting_calibfit(x = x, pch = pch, col = col, line = line, CI = CI, xlab = xlab, ylab = ylab, xlim = xlim, ylim = ylim, points = FALSE, plot = plot, ...)
}


#' @rdname plots
#' @method points CALIBFIT
#' @exportS3Method points CALIBFIT
points.CALIBFIT <- function(x,
                            pch = 2,
                            col = "red",
                            line = list(show = TRUE, col = "red"),
                            CI = list(show = TRUE, col = "red"),
                            plot = TRUE,
                            ...) {
  .complete_args(points.CALIBFIT)

  plotting_calibfit(x = x, pch = pch, col = col, line = line, CI = CI, xlab = NULL, ylab = NULL, points = TRUE, plot = plot, ...)
}

plotting_calibfit <- function(x, pch, col, line, CI, xlab, ylab, xlim = NULL, ylim = NULL, points = FALSE, plot = TRUE, ...) {
  if (!inherits(x, "CALIBFIT")) {
    stop("This function must be called on an object of class CALIBFIT.")
  }

  if (x$method == "desk" && !points && (is.null(xlim) || is.null(ylim))) {
    stop("Since no calibration points have been loaded, xlim & ylim must be defined to indicate the range of the x- and y-axes. Call again the plotting function again after adding e.g. xlim = c(-100, 0), ylim = c(-45, -15) in the function call.")
  }

  if (x$method == "desk" && points && is.null(xlim) && is.null(ylim)) {
    xlim <- ylim <- c(-1e6, 1e6)
  }

  x_var <- switch(x$method,
    wild = x$data$mean_source_value,
    lab = x$data$source_value,
    desk = xlim
  )

  y_var <- switch(x$method,
    wild = x$data$sample_value,
    lab = x$data$sample_value,
    desk = ylim
  )

  ## prepare design matrix
  xs <- with(
    x$data,
    seq(min(x_var),
      max(x_var),
      length.out = 100
    )
  )
  X <- cbind(1, xs)

  ## compute fitted values (in all case so as to return them even if not displayed)
  fitted <- X %*% x$param

  ## compute CI (in all case so as to return it even if not displayed)
  fixedVar <- rowSums(X * (X %*% x$fixefCov)) ## = diag(X %*% x$fixefCov %*% t(X))
  if (any(fixedVar < 0)) {
    fixedVar[fixedVar < 0] <- 0
    warning("Some negative estimates of variances are considered null. Negative estimates of variances are a sign that numerical problems occurred during the fitting of the calibration.")
  }
  lwr <- fitted + stats::qnorm(0.025) * sqrt(fixedVar)
  upr <- fitted + stats::qnorm(0.975) * sqrt(fixedVar)

  if (is.null(xlim)) {
    xlim <- range(x_var, na.rm = TRUE)
  }

  if (is.null(ylim)) {
    if (CI$show) {
      ylim <- range(lwr, y_var, upr, na.rm = TRUE)
    } else {
      ylim <- range(y_var, na.rm = TRUE)
    }
  }

  ## remove fake points used for the construction of the plot when using calibration method "desk"
  if (x$method == "desk") {
    col <- NULL
  }

  if (!points && plot) {
    with(
      x$data,
      graphics::plot.default(y_var ~ x_var,
        xlab = xlab,
        ylab = ylab,
        xlim = xlim,
        ylim = ylim,
        las = 1,
        pch = pch,
        col = col,
        ...
      )
    )
  } else if (plot) {
    with(
      x$data,
      graphics::points.default(y_var ~ x_var, pch = pch, col = col, ...)
    )
  }

  ## plot regression line
  if (line$show && plot) {
    graphics::points(fitted ~ xs, col = line$col, lwd = 2, type = "l")
  }

  ## plot CI
  if (CI$show && plot) {
    graphics::points(lwr ~ xs, col = CI$col, lty = 2, type = "l")
    graphics::points(upr ~ xs, col = CI$col, lty = 2, type = "l")
  }

  ## return for plots outside IsoriX
  out <- data.frame(source_value = xs, sample_fitted = fitted, sample_lwr = lwr, sample_upr = upr)

  ## tweak to please codetools::checkUsagePackage('IsoriX', skipWith = TRUE)
  rm(fitted, fixedVar)

  return(invisible(out))
}


#' @rdname plots
#' @method plot SpatRaster
#' @exportS3Method plot SpatRaster
plot.SpatRaster <- function(x, ...) {
  print(rasterVis::levelplot(x, margin = FALSE, ...))
  return(invisible(NULL))
}


.build_additional_layers <- function(x, sources, calibs, assigns = NULL, borders, mask, mask2 = NULL) {
  ## This function should not be called by the user.
  ## It builds the additional layers for the plots.

  ## layer for sources
  if (!sources$draw) {
    sources_layer <- latticeExtra::layer()
  } else {
    sources_layer <- latticeExtra::layer(
      lattice::lpoints(sources,
        col = pt$col,
        cex = pt$cex,
        pch = pt$pch,
        lwd = pt$lwd
      ),
      data = list(
        sources = x$sp_points$sources,
        pt = sources
      )
    )
  }

  ## layer for calibration points
  if (is.null(calibs)) {
    calibs_layer <- latticeExtra::layer()
  } else {
    if (!calibs$draw) {
      calibs_layer <- latticeExtra::layer()
    } else {
      calibs_layer <- latticeExtra::layer(
        lattice::lpoints(calibs,
          col = pt$col,
          cex = pt$cex,
          pch = pt$pch,
          lwd = pt$lwd
        ),
        data = list(
          calibs = x$sp_points$calibs,
          pt = calibs
        )
      )
    }
  }

  ## layer for assignment points
  if (is.null(assigns)) {
    assigns_layer <- latticeExtra::layer()
  } else {
    if (!assigns$draw) {
      assigns_layer <- latticeExtra::layer()
    } else {
      assigns_layer <- latticeExtra::layer(
        lattice::lpoints(assigns,
          col = pt$col,
          cex = pt$cex,
          pch = pt$pch,
          lwd = pt$lwd
        ),
        data = list(
          assigns = x$sp_points$assigns,
          pt = assigns
        )
      )
    }
  }

  ## layer for country borders
  if (is.null(borders$borders)) {
    borders_layer <- latticeExtra::layer()
  } else {
    borders_layer <- latticeExtra::layer(
      lattice::lpolygon(b$borders,
        lwd = b$lwd,
        border = b$col
      ),
      data = list(b = borders)
    )
  }

  ## layer for mask
  if (is.null(mask$mask)) {
    mask_layer <- latticeExtra::layer()
  } else {
    mask_layer <- latticeExtra::layer(
      lattice::lpolygon(m$mask,
        col = m$fill,
        border = m$col,
        lwd = m$lwd
      ),
      data = list(m = mask)
    )
  }

  if (is.null(mask2$mask)) {
    mask2_layer <- latticeExtra::layer()
  } else {
    mask2_layer <- latticeExtra::layer(
      lattice::lpolygon(m$mask,
        col = m$fill,
        border = m$col,
        lwd = m$lwd
      ),
      data = list(m = mask2)
    )
  }

  layers <- list(
    sources_layer = sources_layer,
    calibs_layer = calibs_layer,
    borders_layer = borders_layer,
    assigns_layer = assigns_layer,
    mask_layer = mask_layer,
    mask2_layer = mask2_layer
  )

  ## tweak to please R CMD check
  b <- m <- pt <- NULL
  return(layers)
}
