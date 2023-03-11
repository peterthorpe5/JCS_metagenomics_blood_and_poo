# JCS_metagenomics_blood_and_poo

The metagenomics folder contains the current methods for both the mapping to the de novo database (and how to generate the database, what was in the database) and metagenomic assembly, classification and krona chart approach. All scripts are availble here to reproduce the methods. All python scripts require biopython. 

I recomend using conda to install envs. See the conda power point if you dont know what that is. 

Good luck. 


#The files in this directory are:

.
├── README.md
├── base_calling
│   ├── README
│   └── basecall_real.sh
├── bioinformatics_training_material
│   └── genome_assembly_workshop_with_screenshots
│       ├── ASSESSMENT.txt
│       ├── Bioinformatic_analysis_and_its_appplications.pptx
│       ├── Genome_assembly_commands.sh
│       ├── Getting_started_b.pptx
│       ├── I am  badly named file.txt
│       ├── LICENSE
│       ├── README.md
│       ├── example
│       │   └── boogie_file.txt
│       ├── genome_diagram
│       │   ├── Genome_diagram.py
│       │   ├── Genome_diagram_multi_contigs.py
│       │   ├── README.rst
│       │   ├── multiple_contigs_DOES_NOT_WORK_for_some
│       │   │   ├── GFF_to_EMBL.pl
│       │   │   ├── Genome_diagram_all_contigs.py
│       │   │   ├── README.rst
│       │   │   ├── Seq.pm
│       │   │   └── split_up_EMBLfile_individual_files.py
│       │   └── rewrite_as_fasta.py
│       ├── graphs
│       │   ├── graph_K18.png
│       │   ├── graph_K53.png
│       │   ├── unicycler.zip
│       │   ├── unicycler_graph.png
│       │   ├── velvet_k18.zip
│       │   └── velvet_k53.zip
│       ├── powerpoint
│       │   ├── 1_ASSEMBLY_WORKSHOP.pptx
│       │   ├── 2_Getting_connected.pptx
│       │   ├── 3_basic_UNIX.pptx
│       │   ├── 4_Shell_scripting.pptx
│       │   ├── 5_qsub.pptx
│       │   ├── 5_sbatch.pptx
│       │   ├── 6_assembly.pptx
│       │   ├── 7_Conda.pptx
│       │   ├── Genome_assembly_slides.pptx
│       │   ├── Kmers_and_graphs.pptx
│       │   └── kenedy_getting_started-V1.pptx
│       ├── precomputed_assembly_stats
│       │   ├── ALL_ASSEMBLIES.txt
│       │   └── all_assemblies_pre_computed.xlsx
│       ├── reads
│       │   └── download.sh
│       ├── shell_scripts
│       │   ├── Example.sh
│       │   ├── FastQC.sh
│       │   ├── assemble_all_odd_kmers.sh
│       │   ├── assembly.sh
│       │   ├── blast.sh
│       │   ├── install-bioconda.sh
│       │   ├── predict_genes.sh
│       │   ├── read_donwloads.sh
│       │   ├── scaffold_stats.pl
│       │   ├── spades.sh
│       │   ├── trim_assemb_predict_blast_advanced_coding.sh
│       │   ├── trimmomatic.sh
│       │   └── unicycler.sh
│       ├── shell_scripts_kennedy
│       │   ├── Example.sh
│       │   ├── FastQC.sh
│       │   ├── assemble_all_odd_kmers.sh
│       │   ├── assembly.sh
│       │   ├── blast.sh
│       │   ├── predict_genes.sh
│       │   ├── read_donwloads.sh
│       │   ├── spades.sh
│       │   ├── trim_assemb_predict_blast_advanced_coding.sh
│       │   ├── trimmomatic.sh
│       │   └── unicycler.sh
│       └── unicycler_prerun
│           ├── 005_polished.gfa
│           ├── Genome_diagram.py
│           ├── PROKKA_10052020.gbk
│           ├── PROKKA_10052020.pdf
│           ├── PROKKA_10052020_circular.pdf
│           └── assembly.fasta
├── mapping_nanopore_reads_to_plas_and_outgroups
│   ├── README
│   ├── create_randoom_suffles.sh
│   ├── final_genomes.txt
│   ├── map_to_genomes.sh
│   ├── map_to_genomes_random.sh
│   ├── mask_fasta.py
│   └── shuffle_fasta.py
└── metagenomics
    ├── 1_basecall_real.sh
    ├── 2_Genome_assembly_slides.pptx
    ├── 3_example_cat_reads.sh
    ├── 5_remove_host_reads.sh
    ├── 6C_map_to_genomes_random.sh
    ├── 6_map_to_plas_outgroup_genomes.sh
    ├── 6b_create_random_shuffles.sh
    ├── 7_flye_metagenomic_assembly.sh
    ├── 8_meta_tax_classif_kracken2.sh
    ├── 9_krona_example.sh
    ├── generate_db_to_map_to
    │   ├── README
    │   ├── README_dataset_to_map_against_remove_host
    │   ├── create_randoom_suffles.sh
    │   ├── download_ncbi.py
    │   ├── download_ncbi_cds.py
    │   ├── download_ncbi_genomics.py
    │   ├── map_to_genomes.sh
    │   ├── map_to_genomes_random.sh
    │   ├── mapping_hits
    │   ├── mask_fasta.py
    │   ├── outgroups.txt
    │   └── shuffle_fasta.py
    ├── get_fa_read_out_from_fq.py
    └── remove_dup_fq.py
