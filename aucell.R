#AUCELL 

aucell_hallmark <- function(object, hallmarks){
  
  hallmarks_pathways <- msigdbr(species = "Homo sapiens", category = 'H', subcategory = NULL)
  hallmarks_pathways <- split(x = hallmarks_pathways$gene_symbol, f = hallmarks_pathways$gs_name)
  #this code takes the hallmark pathway and splits it into vectors with each pathway and the genes that belong to each pathway
  
  expr <- GetAssayData(object,
                       assay = "SCT",
                       layer = "counts")
  
  geneRanking <- AUCell_buildRankings(expr, nCores = 36, splitByBlocks = TRUE)
  auc_score <- AUCell_calcAUC(rankings = geneRanking, geneSets = hallmarks_pathways, aucMaxRank = nrow(geneRanking)*0.1)
  
  
  #make a data frame with ALL of the different types of auc scoring generated with different gene sets
  auc_score <- as.data.frame(t(assay(c(auc_score))))
  auc_score_scaled <- as.data.frame(scale(auc_score))
  object <- AddMetaData(object, metadata = auc_score_scaled)
  
  featureplot1 <- FeaturePlot(object, features = hallmarks, label = FALSE, repel = TRUE, order = T) & scale_colour_gradientn(colours = rev(brewer.pal(n = 11, name = "RdYlBu"))) 
  return(featureplot1)
  
}

