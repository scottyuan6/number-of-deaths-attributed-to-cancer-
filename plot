library(ggplot2)

# Assuming your data frame is named df
ggplot(data = df, aes(x = Year, y = Deaths_Attributed_to_Cancer, group = Hospital, color = Hospital)) +
  geom_line() +
  geom_point() +
  theme_minimal() +
  labs(title = "Cancer-Attributed Deaths Over 20 Years by Hospital",
       y = "Deaths Attributed to Cancer",
       x = "Year")

library(rstanarm)

# Fitting a Poisson regression model
model <- stan_glm(Deaths_Attributed_to_Cancer ~ Year + as.factor(Hospital), 
                  data = df, 
                  family = poisson(link = "log"),
                  prior = normal(0, 2.5), 
                  prior_intercept = normal(0, 10),
                  cores = 2, # Adjust based on your system
                  iter = 2000)

# Check the summary of the model
print(summary(model))

# Plotting diagnostics
plot(model)
