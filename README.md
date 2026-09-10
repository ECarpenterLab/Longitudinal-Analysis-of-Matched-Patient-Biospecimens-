# Single Cell RNA Sequencing Repository Overview

This repository contains code used for single-cell RNA sequencing analysis performed in the paper:

[Longitudinal Analysis of Matched Patient Biospecimens Reveals Neural Reprogramming of Cancer-Associated Fibroblasts Following Chemotherapy in Pancreatic Cancer]

---

## How to Reproduce the Analysis

### Repository Structure

- **`DATA/`**  
  Contains low-size input data, annotations, and the `samples_info` spreadsheet for scRNA-seq analysis.  
  Large data files must be downloaded as described in `Data_Acquisition` prior to running scripts.
  Update the file path in the samples_info sheet to match the path from your working directory.

- **`MARKDOWN/`**  
  Contains raw markdown script files corresponding to each section of the analysis. This folder serves as the primary working directory.
  
- **`OBJECTS/`**  
  The seurat object and filtered matrices to be downloaded into this can be found at the NIH Gene Expression Omnibus database GSE345774.

The processed and annotated Seurat objects generated from the below scripts should be saved into this folder:
  - [`/MARKDOWN/00_ambient_RNA_correction.rmd`](/MARKDOWN/00_ambient_RNA_correction.rmd)
  - [`/MARKDOWN/01_Generating_Merged_Object.Rmd`](/MARKDOWN/01_Generating_Merged_Object.Rmd)
  - [`/MARKDOWN/03_Merging_PT1475_Recurrence_Timepoint.Rmd`](/MARKDOWN/03_Merging_PT1475_Recurrence_Timepoint.Rmd)

  If using the downloaded Merged_Longitduinal_Object, it was generated at line 89 MARKDOWN `#01` and should be continued from there.
  - [`/MARKDOWN/01_Generating_Merged_Object.Rmd`](/MARKDOWN/01_Generating_Merged_Object.Rmd)
    
  Newly generated objects from MARKDOWN `#00` should be saved in this sub-directory.
  Seurat object for the spatial transcriptomics analysis was acquired from [DOI: 10.1038/s41586-025-08927-x](https://www.nature.com/articles/s41586-025-08927-x).
  Seurat object of healthy donor pancreata samples were acquired from [DOI: 10.1158/2159-8290.CD-23-0013](https://aacrjournals.org/cancerdiscovery/article/13/6/1324/726992/Analysis-of-Donor-Pancreata-Defines-the).

- **`Utils/`**  
  Contains utility functions used across scripts for modular and reproducible analysis.

- **`DOCUMENTS/`**  
  Contains the rendered markdown files as .html files. 
  - [`/DOCUMENTS/00_ambient_RNA_correction.html`](/DOCUMENTS/00_ambient_RNA_correction.html)
  - [`/DOCUMENTS/01_Generating_Merged_Object.html`](/DOCUMENTS/01_Generating_Merged_Object.html)

---

## Single-Cell RNA Sequencing Analysis

### Alignment and Preprocessing

FASTQ files were aligned to the hg38 reference genome using **CellRanger v7.1.0**.

Ambient RNA contamination was corrected using  
[SoupX](https://github.com/constantAmateur/SoupX)  
as implemented in:

- [`/MARKDOWN/00_ambient_RNA_correction.rmd`](/MARKDOWN/00_ambient_RNA_correction.rmd)

---

### Cluster Annotation

Longitudinal clusters were labeled and subset using markers published in literature:

- [`/MARKDOWN/01_Generating_Merged_Object.Rmd`](/MARKDOWN/01_Generating_Merged_Object.Rmd)

---

### Fibroblast Characterization

Published and internally derived gene signatures were mapped onto extracted cancer-associated fibroblasts using  
[AUCell](https://github.com/aertslab/AUCell), as implemented in:

- [`/MARKDOWN/07_Fibroblast_object_characterization.Rmd`](/MARKDOWN/07_Fibroblast_object_characterization.Rmd)

---

### Copy Number Variation Analysis

Inferred copy number variation (CNV) analysis of epithelial populations was performed using:

- [`/MARKDOWN/02_Numbat.Rmd`](/MARKDOWN/02_Numbat.Rmd)

Ductal cells from healthy donor pancreata were used as the reference population.

---

### Cell-Type Specific Analyses

Each major cell type was analyzed independently:

- **T cells**:  
  [`/MARKDOWN/05_T_Cell_CHaracterization.Rmd`](/MARKDOWN/05_T_Cell_CHaracterization.Rmd)

- **Myeloid cells**:  
  [`/MARKDOWN/06_Myeloid_Cell_Characterization.Rmd`](/MARKDOWN/06_Myeloid_Cell_Characterization.Rmd)

---

### Cell–Cell Communication Analysis

Ligand–receptor inference on the longitudinal object was performed using CellChat:

- [`/MARKDOWN/09_CellChat_Overall_Longitudinal.Rmd`](/MARKDOWN/09_CellChat_Overall_Longitudinal.Rmd)

---

### Integration with External Datasets

Samples were merged with previously published healthy and tumor pancreas scRNA-seq datasets (PMID: 37021392).

Integration was performed using the recommended  
[Seurat rPCA MNN integration workflow](https://satijalab.org/seurat/articles/integration_rpca.html), implemented in:

- [`/MARKDOWN/10_merging_external_CAF_datasets_and_integrating.Rmd`](/MARKDOWN/10_merging_external_CAF_datasets_and_integrating.Rmd)

Prior to full integration, cancer-associated fibroblasts (CAFs) from both datasets were queried in:

- [`/MARKDOWN/08_Merging_Gift_of_Life_fibroblasts.Rmd`](/MARKDOWN/08_Merging_Gift_of_Life_fibroblasts.Rmd)

---

### Patient-Specific Analyses

Patient 1475 recurrence timepoint analysis:

- [`/MARKDOWN/03_Merging_PT1475_Recurrence_Timepoint.Rmd`](/MARKDOWN/03_Merging_PT1475_Recurrence_Timepoint.Rmd)

Epithelial cell characterization for Patient 1475:

- [`/MARKDOWN/04_PT1475_Epithelial_Cell_Characterization.Rmd`](/MARKDOWN/04_PT1475_Epithelial_Cell_Characterization.Rmd)

---

# Bulk Cell RNA Sequencing Repository Overview

This repository contains code used for bulk RNA sequencing analysis performed in the paper. The processed expected gene counts and featureCounts output files required for this analysis can be found on Gene Expression Omnibus... and the raw unprocessed files will be at dbgap accession number...

---

- **`MARKDOWN/`**  
Contains raw markdown script files corresponding to each section of the analysis. This folder serves as the primary working directory.

- **`DOCUMENTS/`**  
Contains the rendered markdown files as .html files. 

---

# Execution Order (Recommended)

For full reproducibility, scripts should be run in the following general order:

1. Alignment and preprocessing  
2. Object generation and annotation  
3. CNV analysis  
4. Cell-type–specific characterization  
5. CAF signature mapping  
6. Dataset integration  
7. Cell–cell communication analysis
8. Trajectory analysis
9. Spatial Transcriptomics analysis
10. bulk RNA sequencing analysis

---

