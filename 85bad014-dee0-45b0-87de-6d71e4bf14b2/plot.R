library(tibble)
library(ggplot2)


data <- tribble(
  ~SYMBOLS, ~Category, ~Group, ~Expression_mean, ~Expression_sd,
  "ANPEP",  "Pericyte Markers", "Norm", 1.00, 0.204,
  "ANPEP",  "Pericyte Markers", "Hyp",  1.28, 0.457,
  "CALD1",  "Pericyte Markers", "Norm", 1.00, 0.0513,
  "CALD1",  "Pericyte Markers", "Hyp",  0.772, 0.124,
  "CSPG4",  "Pericyte Markers", "Norm", 1.00, 0.0946,
  "CSPG4",  "Pericyte Markers", "Hyp",  2.32, 0.882,
  "PDGFRB", "Pericyte Markers", "Norm", 1.00, 0.0987,
  "PDGFRB", "Pericyte Markers", "Hyp",  1.62, 0.502
)

# Convert Group to factor with desired order
data$Group <- factor(data$Group, levels = c("Norm", "Hyp"))

# Plot
aaa <- ggplot(data, aes(x = Group, y = Expression_mean, fill = Group)) +
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

aaa


ggsave("output_figure.png", width = 4, height = 3)
write.csv(data, "output_data.csv", row.names = FALSE)

