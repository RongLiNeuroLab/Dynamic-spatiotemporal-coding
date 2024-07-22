library(corrplot)

equivalence = read.table('equivalence_sites_group.txt')
dynamic_equivalence = read.table('dynamic_equivalence_sites_group.txt')
stable_equivalence = read.table('stable_equivalence_sites_group.txt')

entropy = read.table('entropy_sites_group.txt')
dynamics = read.table('dynamic_sites_group.txt')
switch = read.table('switch_sites_group.txt')

col3 = hcl.colors(12, "Spectral",rev = TRUE)

corrplot(corr=cor(dynamics),col=col3,method = "circle",addCoef.col = "black",
         col.lim = c(0,1),number.cex = 1.8,cl.cex =1.5,addgrid.col="grey",tl.col = "black",tl.pos = "n"
)
corrplot(corr=cor(switch),col=col3,method = "circle",addCoef.col = "black",
         col.lim = c(0,1),number.cex = 1.8,cl.cex =1.5,addgrid.col="grey",tl.col = "black",tl.pos = "n"
)
corrplot(corr=cor(entropy),col=col3,method = "circle",addCoef.col = "black",
         col.lim = c(0,1),number.cex = 1.8,cl.cex =1.5,addgrid.col="grey",tl.col = "black",tl.pos = "n"
)

corrplot(corr=cor(stable_equivalence),col=col3,method = "circle",addCoef.col = "black",
         col.lim = c(0,1),number.cex = 1.8,cl.cex =1.5,addgrid.col="grey",tl.col = "black",tl.pos = "n"
)
corrplot(corr=cor(equivalxxence),col=col3,method = "circle",addCoef.col = "black",
         col.lim = c(0,1),number.cex = 1.8,cl.cex =1.5,addgrid.col="grey",tl.col = "black",tl.pos = "n"
)
corrplot(corr=cor(stable_equivalence),col=col3,method = "circle",addCoef.col = "black",
         col.lim = c(0,1),number.cex = 1.8,cl.cex =1.5,addgrid.col="grey",tl.col = "black",tl.pos = "n"
)

