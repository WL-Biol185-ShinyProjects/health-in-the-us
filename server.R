library(shiny)

# Define server logic required to draw a histogram
function(input, output) {
  
  output$BarByState <- renderPlot({
    outputstates %>%
filter(State == "California") %>%   # change to your state
group_by(Category) %>%
summarise(total_dollars = sum(Dollars, na.rm = TRUE)) %>%
ggplot(aes(x = reorder(Category, total_dollars),
y = total_dollars,
fill = Category)) +   # <-- different color per category
geom_col() +
labs(
title = "Total Dollars Spent by Category (California)",
x = "Category",
y = "Total Dollars"
) +
theme_minimal() +
theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
theme(legend.position = "none")   # hides legend since colors = categories
    
  })
  
}