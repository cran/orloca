#' Plots of the min-sum objective function
#'
#' \code{contour} provides a graphical representations of min-sum function (\code{zsum}).
#'
#' @name contour.loca.p
#' @aliases contour.loca.p contour,loca.p-method
#'
#' @details
#' If \eqn{p<1} then \eqn{l_p} ara not a norm, so only \eqn{p>=1} are valid values.
#'
#' @keywords classes hplot
#' @param x The loca.p object to compute the objective.
#' @param lp If given, then \eqn{l_p} norm will be used instead of the Euclidean norm.
#' @param xmin The minimum value for x axis.
#' @param xmax The maximum value for x axis.
#' @param ymin The minimum value for y axis.
#' @param ymax The maximum value for y axis.
#' @param n The number of divisions for grid.
#' @param img A raster image to plot on background.
#' @param xleft The left position of the image.
#' @param ybottom The bottom position of the image.
#' @param xright The right position of the image.
#' @param ytop The top position of the image.
#' @param \ldots Other options.
#' @return \code{contour.loca.p} plots a contour plot of min-sum function (\code{zsum}).
#' @seealso See also \code{\link{orloca-package}}, \code{\link{plot.loca.p}} and \code{\link{loca.p}}.
#' @examples
#' # A new unweighted loca.p object
#' loca <- loca.p(x = c(-1, 1, 1, -1), y = c(-1, -1, 1, 1))
#' 
#' # The contour plot of min-sum function for loca (a loca.p object)
#' contour(loca)
#' 
#' @export
contour.loca.p <- function(x, lp=numeric(0), xmin=min(min(x@x), xleft), xmax=max(max(x@x), xright), ymin=min(min(x@y), ybottom), ymax=max(max(x@y), ytop), n=100, img=NULL, xleft=min(x@x), ybottom=min(x@y), xright=max(x@x), ytop=max(x@y), ...)
   {
   .x<-seq(xmin, xmax, length.out=n)
   .y<-seq(ymin, ymax, length.out=n)
   .z<-matrix(1, nrow=n, ncol=n, byrow=TRUE)
   if (length(lp) == 0)
     {
       for(i in 1:n)
         for(j in 1:n)
           .z[i,j] <- zsum(x, .x[i], .y[j])
     }
   else if (lp >= 1)
     {
       for(i in 1:n)
         for(j in 1:n)
           .z[i,j] <- zsumlp(x, .x[i], .y[j], p=lp)
    }
   else stop(paste(lp, gettext("is not a valid value for lp, use 1 <= lp", domain = "R-orloca")))
   contour(.x, .y, .z, ...) 
   if (!is.null(img)) {
     if (is.raster(.img <- img) || is.raster(.img <- as.raster(img))) {
       rasterImage(.img, xleft, ybottom, xright, ytop)
       contour(.x, .y, .z, add=TRUE, ...) 
       }
     else warning(gettext("The given img object is not a raster image and cannot be coerce to it.", domain = "R-orloca"))
   }
   invisible(1)
   }

#' @export
persp.loca.p <- function(x, lp=numeric(0), xmin=min(x@x), xmax=max(x@x), ymin=min(x@y), ymax=max(x@y), n=100, ...)
   {
   .x<-seq(xmin, xmax, length.out=n)
   .y<-seq(ymin, ymax, length.out=n)
   .z<-matrix(1, nrow=n, ncol=n, byrow=TRUE)
   if (length(lp) == 0)
     {
       for(i in 1:n)
         for(j in 1:n)
           .z[i,j] <- zsum(x, .x[i], .y[j])
     }
   else if (lp >= 1)
     {
       for(i in 1:n)
         for(j in 1:n)
           .z[i,j] <- zsumlp(x, .x[i], .y[j], p=lp)
    }
   else stop(paste(lp, gettext("is not a valid value for lp, use 1 <= lp", domain = "R-orloca")))
   persp(.x, .y, .z, ...)
   invisible(1)
   }
