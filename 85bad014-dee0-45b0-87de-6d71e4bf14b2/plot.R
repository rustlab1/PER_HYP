library(ggplot2)

# Read the extracted solution CSV (must be in same folder)
data <- read.csv("extracted_solution.csv")

# Convert Group to factor with desired order
data$Group <- factor(data$Group, levels = c("Norm", "Hyp"))

# Plot
p <- ggplot(data, aes(x = Group, y = Expression_mean, fill = Group)) +
  geom_errorbar(aes(ymin = Expression_mean - Expression_sd,
                    ymax = Expression_mean + Expression_sd),
                width = 0.2, position = position_dodge(0.8), color = "black") +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.6) +
  facet_wrap(~ SYMBOLS, nrow = 1) +
  labs(y = "Normalized gene expression",
       x = NULL,
       title = "canonical pericyte marker") +
  scale_fill_manual(values = c("Norm" = "#2b8cbe", "Hyp" = "#c51b8a")) +
  theme_bw(base_size = 12) +
  theme(
    strip.background = element_blank(),
    strip.text = element_text(size = 11),
    plot.title = element_text(hjust = 0.5, size = 13),
    legend.position = "none",
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )
p
# Save output
ggsave("extracted_solution.jpg", plot = p, width = 4, height = 3)
