% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/IsoriX-datasets.R
\docType{data}
\name{AssignDataBat2}
\alias{AssignDataBat2}
\alias{AssignDataBat2Rev}
\title{Assignment datasets for bat species}
\format{
Two \emph{dataframes} with 244 observations and 3 variables:\tabular{lll}{
    \tab  \tab  \cr
   sample_ID \tab (\emph{factor}) \tab Identification of the animal \cr
   species \tab (\emph{factor}) \tab Animal species name \cr
   sample_value \tab (\emph{numeric}) \tab Hydrogen delta value of the tissue \cr
}
}
\source{
data provided by Voigt CC, Lehmann D & Greif S.
}
\description{
These datasets contain data from Voigt, Lehmann & Greif (2015). It contains
hydrogen delta values of fur keratin from bats captured in 2008, 2009 and
2013 from their roosting sites in Bulgaria. We only retained the bats of the
genus Myotis from the original study. These data can be used as an example to
perform assignments using the function \code{\link{isofind}}.  The difference
between \code{AssignDataBat2} and \code{AssignDataBat2Rev} is that in the latter the bat
fur isotope values were corrected to align with the current delta values for deuterium
for keratin reference materials (Soto et al. 2017, https://doi.org/10.1002/rcm.7893)
ensuring comparability between formerly and more recently normalized datasets of delta values for deuterium.
}
\examples{

head(AssignDataBat2)
str(AssignDataBat2)

}
\references{
Voigt CC, Lehmann D & Greif S (2015). Stable isotope
ratios of hydrogen separate mammals of aquatic and terrestrial food webs.
Methods in Ecology and Evolution 6(11).

Soto DX, Koehler G, Wassenaar LI & Hobson KA (2017). Re-evaluation of the hydrogen stable
isotopic composition of keratin calibration standards for wildlife and forensic
science applications. Rapid Commun Mass Spectrom. 31(14):1193-1203.
doi: 10.1002/rcm.7893. PMID: 28475227.
}
\seealso{
\code{\link{isofind}} to perform assignments
}
\keyword{datasets}
