# This function takes the reclassified_table and the year_selected as inputs 
# and then returns a m x n named matrix with m is the number of cells and
# n is the number of LC classes defined by the reclassification table for each
# year. The row names are the "Cell" string, concatenating "X" and "Y" columns
# separated by underscore "_". The column names are the distinct LC classes.

Get_matrix_by_year = function(reclassified_table,
                                year_selected){
  selected_table = reclassified_table %>% 
    filter(Year == year_selected) %>%
    dplyr::select(X, Y, LC_class)
  
  spread_table = selected_table %>%
    tidyr::unite("Cell", c(X, Y)) %>%
    spread(LC_class, -Cell)
  
  only_vals = spread_table %>%
    dplyr::select(-Cell) %>%
    mutate_all(.funs = function(x){ as.integer(!is.na(x)) })
  
  as.matrix(only_vals) %>% `rownames<-`(spread_table$Cell)
}
