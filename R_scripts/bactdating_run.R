library("ape")
library(BactDating)

t <- read.tree(file="~/pw_fastqs/snp_phylogeny_output/gubbin_out/aligned_pseudogenome.node_labelled.final_tree.tre")
metadata <- read.csv(file="~/Kpn_data/bactdating/dates.csv")
tree_labels<- as.data.frame(t$tip.label)
merged <- merge(tree_labels, metadata, by.x='t$tip.label', by.y='name', all.x = T, all.y=F)
merged2 <- merged[match(t$tip.label, merged$`t$tip.label`),]
#$merged2[is.na(merged2)] <- 0

rooted=initRoot(t,merged2$date)
r=roottotip(rooted,merged2$date)

res=bactdate(unroot(t),merged2$date,nbIts=10000, initSigma=0.000005, updateSigma=T,  updateRoot=T, updateAlpha=T, updateMu=T, model= "relaxedgamma")
plot(res,'treeCI',show.tip.label = T)

res0=bactdate(rooted,merged2$date)



res2=bactdate(unroot(r),merged2$date,nbIts=10000, initSigma=0.000005, updateSigma=T,  updateRoot=T, updateAlpha=T, updateMu=T, model= "relaxedgamma")
plot(res0,'treeCI',show.tip.label = T)

help(package='BactDating')



