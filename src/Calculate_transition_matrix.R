# This function calculates the transition matrix between two years (year_from, 
# and year_to), sourced from the reclassified_table table.

Calculate_transition_matrix = function(reclassified_table, year_from, year_to){
  the_two_years = reclassified_table %>%
    filter(Year %in% c(year_from, year_to)) %>%
    dplyr::select(Year, X, Y, LC_class)
  
  spread_change = the_two_years %>%
    spread(Year, LC_class)
  
  change_tract = spread_change %>%
    tidyr::unite("tract", 3:4)
  
  changes_count = change_tract %>%
    group_by(tract) %>%
    summarize(count = n()) %>%
    mutate(ratio = count / dim(change_tract)[1])
  
  separated_changes = changes_count %>%
    dplyr::select(tract, ratio) %>%
    separate(col = "tract", into = c("from", "to")) %>%
    mutate(from = factor(from, levels = levels(reclassified_table$LC_class)),
           to = factor(to, levels = levels(reclassified_table$LC_class)))
  
  totalratio = separated_changes %>% 
    group_by(from) %>% 
    summarize(total = sum(ratio))
  
  joined_changes = separated_changes %>%
    inner_join(totalratio)
  
  normalized_changes = joined_changes %>%
    mutate(ratio = ratio / total) %>%
    dplyr::select(-total)
  
  changes_two_years = normalized_changes %>%
    spread(to, ratio) %>%
    column_to_rownames("from")
  
  matrix_transition = changes_two_years %>%
    as.matrix()
  
  matrix_transition[is.na(matrix_transition)] = 0
  
  matrix_transition
}
