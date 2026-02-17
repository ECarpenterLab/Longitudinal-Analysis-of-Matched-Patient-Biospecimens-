GSEA_function <- function(patient.markers, object){
  
  ##hallmark genes enrichment
  hallmarks_pathways <- msigdbr(species = "Homo sapiens", category = 'H', subcategory = NULL)
  hallmarks_pathways <- split(x = hallmarks_pathways$gene_symbol, f = hallmarks_pathways$gs_name)
  #this code takes the hallmark pathway and splits it into vectors with each pathway and the genes that belong to each pathway
  
  Idents(object = object) <- "time_point"
  patient.markers$gene <- rownames(patient.markers)
  DEG_patient <- patient.markers %>% arrange(desc(avg_log2FC))
  fold_changes <- DEG_patient$avg_log2FC
  names(fold_changes) <- DEG_patient$gene
  head(fold_changes)
  
  ##GSEA ANALYSIS###
  gsea_patient <- fgsea(hallmarks_pathways, stats = fold_changes, nperm = 1000)
  gsea_sig <- gsea_patient %>% filter(padj < 0.05)
  
  gsea_tidy <- gsea_patient %>% as_tibble() %>% arrange(desc(NES))
  gsea_sig_tidy <- gsea_tidy %>% filter(padj < 0.05)
  
  GSEA_PLOT <- ggplot(gsea_sig,
         aes(reorder(pathway, NES), NES)) +
    geom_col(aes(fill = padj)) +
    coord_flip() +
    labs(x = "Pathway", y = "Normalized Enrichment Score", title = "Hallmark Pathways NES from GSEA")+
    theme_minimal()
  ##this just makes one GSEA hallmarks graph based on the hallmarks. 
  return(GSEA_PLOT)
  
}