estim_skm <- function(dates, status, show.plot = FALSE){
  n = length(dates)
  don <- data.frame(dates, status)
  don <- don %>% 
    arrange(dates) 
  
  date_unique = unique(don$dates)
  if(length(date_unique) == n ){ ## Estimateur en cas de dates non répétées
    ## Le nombre de restant à chaque dates
    ## N'observant qu'une occurrence (évènement ou censure) par date alors,
    ## Le nombre de personnes restant à une date correspond
    ## au nombre de personne restant à la date précédente auquel on retranche 1 
    r = n:1 
    d = don$status
    res = list(xx = c(0,don$dates), 
               yy =  c(1,cumprod(1 - d/r)))
  }else{
    
    effectif = don %>% 
      ## On essai de calculer le nombre de décès et de censure par dates en cas de répétitions
      group_by(dates) %>%  
      summarise(
        ## le nombre de décès pour chaque dates
        d = sum(status), 
        ## le nombre de censure correspondant au nombre de dates moins le nombre de décès calculé dans la ligne plus haut
        c = n() - d 
      )
    ## Calcul du vecteur R
    ## Pour chaque date on calcul les décès et censure survenue jusqu'à cette date
    ## on obtient en faisant cumsum de la somme de d et c
    ## pour obtenir r on fais n moins le résultats précédents
    `d+c` = cumsum(effectif$d + effectif$c)
    # on retire la dernière valeur car elle correspond à n où tout le monde est mort ou censure
    `d+c` = head(`d+c`, -1)  
    r = c(n, n - `d+c`) 
    
    res = list(xx = c(0,date_unique), yy = c(1, cumprod(1 - effectif$d/r)))
    
  }
  if(show.plot == TRUE){
    print(
      ggplot() +
        geom_step(aes(x = res$xx, y = res$yy), lwd = 0.6) +
        theme_light() +
        ggtitle("Estimation de la courbe de survie de Kaplan Meyer")
    )
    
    
    return(res)
    
  }else{
    return(res)
  }
}