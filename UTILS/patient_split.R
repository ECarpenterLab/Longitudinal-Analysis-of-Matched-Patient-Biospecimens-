patient_split <- function(object, sample1, sample2, genelist){
  
  
  Idents(object = object) <- 'sample_id'
  pt <- c(sample1, sample2)
  pt_object <- subset(object, idents = pt)
  Idents(object = pt_object) <- 'time_point'
  table(Idents(pt_object), pt_object$sample_id)
  
  patient <- pt_object
  DefaultAssay(object = patient) <- "CorrectedCounts" #make sure you always use corrected counts when finding markers
  patient_scaled <- ScaleData(patient, features = rownames(patient))
  Idents(object = patient_scaled) <- 'time_point'
  
  patient.markers <- FindMarkers(patient_scaled, ident.1 = "1", ident.2 = "2", assay = "CorrectedCounts", test.use = "MAST", verbose = FALSE, recorrect_umi = FALSE, logfc.threshold = 0)
  #the verbose, prepsctfindmarkers, SCT assay, and re-correct umi are all only included if SCT assay is used. you can leave off for corrected counts. 
  filename <- paste0(sample1, "_de.csv")
  write.csv(patient.markers, file = filename)
  heatmap1 <- DoHeatmap(patient_scaled, features = genelist) + scale_fill_gradientn(colors = rev(RColorBrewer::brewer.pal(n = 10, name = "RdYlBu")))
  pt_object_name <- paste0("pt_object_", sample1)
  pt_markers <- paste0("patient.markers_", sample1)
  assign(pt_object_name, patient_scaled, envir = .GlobalEnv)
  assign(pt_markers, patient.markers, envir = .GlobalEnv)
  object_name <- paste0(sample1, "object.RDS")
  saveRDS(patient_scaled, object_name)
  return(heatmap1)
}

?assign
