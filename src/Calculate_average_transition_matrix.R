# This function calculates the average transition matrix with 
# all_transition_matrices as the input.

Calculate_average_transition_matrix = function(all_transition_matrices){
  all_transition_matrices_multiplied = Reduce("%*%", all_transition_matrices)
  
  L = diag((all_transition_matrices_multiplied %>% eigen)$value)
  U = (all_transition_matrices_multiplied %>% eigen)$vectors
  Uin = ginv(U)
  
  average_transition_matrix = 
    (U %*% (L ^ (1/length(all_transition_matrices))) %*% Uin) %>%
    `colnames<-`(colnames(all_transition_matrices_multiplied)) %>%
    `rownames<-`(rownames(all_transition_matrices_multiplied)) %>%
    print()
}
