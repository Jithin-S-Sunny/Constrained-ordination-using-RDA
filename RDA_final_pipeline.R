
library(vegan)   
library(ggplot2) 
library(dplyr)   

genus_data <- read.csv("level-7.csv", row.names = 1, check.names = FALSE)
metadata <- read.csv("metadata.csv", row.names = 1, check.names = FALSE)

genus_data <- genus_data %>% mutate_all(as.numeric)

genus_data_hellinger <- decostand(genus_data, method = "hellinger")

metadata_numeric <- metadata %>% select_if(is.numeric)

rda_result <- rda(genus_data_hellinger ~ ., data = metadata_numeric)

anova_global <- anova(rda_result, permutations = 999)   
anova_axes <- anova(rda_result, by = "axis", permutations = 999)  

print(anova_global)
print(anova_axes)


site_scores <- scores(rda_result, display = "sites") %>% as.data.frame()
species_scores <- scores(rda_result, display = "species") %>% as.data.frame()
variable_scores <- scores(rda_result, display = "bp") %>% as.data.frame()

site_scores$Sample <- rownames(site_scores)
species_scores$Genus <- rownames(species_scores)
variable_scores$Variable <- rownames(variable_scores)

variable_scores <- variable_scores %>% mutate(RDA1 = RDA1 * 2, RDA2 = RDA2 * 2)

print(variable_scores)

ggplot() +

  geom_point(data = site_scores, aes(x = RDA1, y = RDA2, color = Sample), size = 4, alpha = 0.8) +
  geom_text(data = site_scores, aes(x = RDA1, y = RDA2, label = Sample), vjust = -1, size = 3) +
  
  geom_text(data = species_scores, aes(x = RDA1, y = RDA2, label = Genus), color = "red", size = 3, alpha = 0.7) +
  

  geom_segment(data = variable_scores, aes(x = 0, y = 0, xend = RDA1, yend = RDA2),
               arrow = arrow(length = unit(0.2, "cm")), color = "black") +
  geom_text(data = variable_scores, aes(x = RDA1, y = RDA2, label = Variable),
            color = "black", vjust = 1.2, hjust = 1.2, size = 4) +
  

  labs(title = "Redundancy Analysis (RDA) Biplot",
       x = "RDA1 (Most variation explained)",
       y = "RDA2 (Second-most variation explained)") +
  theme_minimal()
