# Constrained-ordination-using-RDA
Redundancy Analysis (RDA) is a multivariate statistical method used to explore the relationship between response variables (e.g., genus abundances) and explanatory variables (e.g., environmental metadata).

Redundancy Analysis (RDA) Pipeline


This script performs Redundancy Analysis  to examine how environmental metadata influences genus composition. It reads genus abundance data and metadata, applies Hellinger transformation, runs RDA, and visualizes the results.

1. level-7.csv - Genus abundance data (rows = samples, columns = genera).
2. metadata.csv - Metadata (rows = samples, columns = environmental factors).


Result Interpretation on the sample data:

1.
Model: rda(formula = genus_data_hellinger ~ site + Temp + PE + PS + PVC + Mealworm + Superworm, data = metadata_numeric)

         Df    Variance      F       Pr(>F)    
Model    6     0.21148       4.6095  0.001 
Residual 69    0.52760     

Takeaway:
The overall RDA model is statistically significant (p = 0.001), meaning that the environmental variables significantly explain variations in genus composition.
The model explains 21.15% of the total variance in the dataset.
Residual variance (52.76%) indicates unexplained variation, possibly due to other unmeasured factors.

2. 
RDA1      1  0.12873 16.8348  0.001 
RDA2      1  0.03683  4.8166  0.003 
RDA3      1  0.02432  3.1806  0.040 
RDA4      1  0.01575  2.0594  0.218    
RDA5      1  0.00461  0.6034  0.979    
RDA6      1  0.00124  0.1623  1.000  

Takeaway:
RDA1 (p = 0.001, 12.87% variance explained) is the most important axis, meaning the strongest environmental gradient influencing genus composition.
RDA2 (p = 0.003, 3.68% variance explained) is also statistically significant.

3. 
        RDA1        RDA2              Variable
site   -0.27999597   -0.02490600      site
Temp    1.72310715   -0.51962448      Temp
PE     -0.01851582   -0.05580422        PE
PS     -0.16433138    0.82320129        PS
X      -0.59492258   -1.67221725      X
Y      -0.20067748    0.99281882      Y

Takeaway:
Temperature (Temp, RDA1 = 1.72) is the strongest driver, meaning it significantly influences genus composition.
Mealworm (-0.59 on RDA1, -1.67 on RDA2) negatively correlates with RDA1 and RDA2, meaning that samples with more mealworm-associated genera are compositionally different.
Superworm (0.99 on RDA2) strongly influences RDA2, meaning it defines an alternative genus composition compared to mealworm.
PS (0.82 on RDA2) suggests that polystyrene (PS) exposure affects microbial community composition.
PE has negligible influence, as its RDA1 and RDA2 loadings are close to zero.

