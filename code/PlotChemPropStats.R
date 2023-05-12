library(tidyverse)
library(gridExtra)
library("viridis")
library(ggsci)
library(ggpubr)
library(cowplot)

df <- read_csv("~/Documents/ChemFinalProject/Prism_fixed.csv")
df_clean <- df %>% mutate(Drug = SMILES) %>% 
  select(Drug, Y)

write_csv(df_clean, "~/Documents/ChemFinalProject/PRISM_Clean_V2.csv")


tdp_out <- read_csv("~/Documents/ChemFinalProject/tdp_chemprop_stats.csv")
tdp_out <- tdp_out %>% mutate(descriptor = factor(descriptor, levels = c("none", "reactivity", "H_bonding", "physical_descriptors", "functional_group", "all_features")))
ggplot(tdp_out, aes(descriptor, value, group = metric, fill = metric)) + 
  geom_bar(stat = "identity", position = "dodge") + theme_bw() + 
  scale_fill_npg() + scale_fill_npg() + facet_wrap(~type, nrow = 1) + 
  geom_text(aes(label=round(value, 2)), position=position_dodge(width=0.9), vjust=-0.25) + 
  ylim(0, 0.8) + theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust=1))
ggsave(file="~/Documents/ChemFinalProject/tdp_metrics.png", units = "cm", width = 28, height = 12, dpi = 300) #saves g

