# ThermalStressCompilation
Compilation of thermal performance curves of lepidopterans

## Descriptions of files in repo

### Calculating variables

Development rate: DR1_variablecalculation.Rmd
Survival: S1_variablecalculation.Rmd
Performance: P1_variablecalculation.Rmd
T0: T0_G.Rmd

### Creating table with all response variables
*This requires the above 4 scripts to be run*

MergeResponseVariableTables.Rmd

### Most current analyses
*This requires the above table to be created*

These include statistics and graphical explorations of the variables. 

Development rate: DR2_analyses.Rmd
Survival: S2_analyses.Rmd
Performance: P2_analyses.Rmd
Symmetry/bias:  AnnaSymmetry.Rmd
TO: T0_Analyses.Rmd

### Exploratory Graphs

Showing trends across all sets: AnnaSummaryGraphs.Rmd
Creation of the summary figure: MethodsFigure.Rmd
Very early graphs: ExploratoryFigures.R

### Data cleaning/manipulation scripts

CalculateDevelopmentRate.R
ScaleDevelopmentTime.R
SetCharacterization.R
SummaryStats.R

### Old/not needed files

AnnaCombinedAnalyses.Rmd
AnnaWorkingScript.Rmd
CumulativeSurvival.Rmd
CurveFitting.Rmd
DevelopmentRateAnalysis.Rmd
PerformanceAnalysis.Rmd
Report.Rmd
SurvivalAnalysis.Rmd

