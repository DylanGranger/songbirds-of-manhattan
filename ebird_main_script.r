install.packages("auk")
install.packages("dplyr")
library(auk)
library(dplyr)


f_in <- file.path("ebd_US-NY-061_201501_202309_unv_smp_relSep-2023.txt")
taxon_names <- read_excel("ebird_taxonomy_v2022.xlsx")
taxon_names <- taxon_names %>% filter(ORDER1 == 'Passeriformes')
ebd <- auk_ebd(f_in)


ebd_filters <- auk_date(ebd, date = c("2018-04-01", "2018-05-31"))
ebd_filtered <- auk_filter(ebd_filters, file="2018.txt", overwrite = TRUE)
birds2018 <- read_ebd(ebd_filtered)
songbirds2018 <- birds2018[birds2018$`taxonomic_order` %in% taxon_names$TAXON_ORDER, ]
write.csv(songbirds2018, "songbirds2018.csv")
taxon_counts <- table(songbirds2018$`taxonomic_order`)
taxon_counts_df_2018 <- as.data.frame(taxon_counts)
taxon_counts_df_2018 <- taxon_counts_df_2018[order(-taxon_counts_df_2018$Freq), ]
songbirds2018_sp <- merge(taxon_counts_df_2018, taxon_names, by.x = "Var1", by.y = "TAXON_ORDER", all.x = TRUE) %>%
  select(Var1, Freq, PRIMARY_COM_NAME, SCI_NAME)
songbirds2018_sp <- songbirds2018_sp[order(-songbirds2018_sp$Freq), ]
write.csv(songbirds2018_sp, "songbird_count_2018.csv")

ebd_filters <- auk_date(ebd, date = c("2020-04-01", "2020-05-31"))
ebd_filtered <- auk_filter(ebd_filters, file="2020.txt", overwrite = TRUE)
birds2020 <- read_ebd(ebd_filtered)
songbirds2020 <- birds2020[birds2020$`taxonomic_order` %in% taxon_names$TAXON_ORDER, ]
write.csv(songbirds2020, "songbirds2020.csv")
taxon_counts <- table(songbirds2020$`taxonomic_order`)
taxon_counts_df_2020 <- as.data.frame(taxon_counts)
taxon_counts_df_2020 <- taxon_counts_df_2020[order(-taxon_counts_df_2020$Freq), ]
songbirds2020_sp <- merge(taxon_counts_df_2020, taxon_names, by.x = "Var1", by.y = "TAXON_ORDER", all.x = TRUE) %>%
  select(Var1, Freq, PRIMARY_COM_NAME, SCI_NAME)
songbirds2020_sp <- songbirds2020_sp[order(-songbirds2020_sp$Freq), ]
write.csv(songbirds2020_sp, "songbird_count_2020.csv")

ebd_filters <- auk_date(ebd, date = c("2022-04-01", "2022-05-31"))
ebd_filtered <- auk_filter(ebd_filters, file="2022.txt", overwrite = TRUE)
birds2022 <- read_ebd (ebd_filtered)
songbirds2022 <- birds2022[birds2022$`taxonomic_order` %in% taxon_names$TAXON_ORDER, ]
write.csv(songbirds2022, "songbirds2022.csv")
taxon_counts <- table(songbirds2022$`taxonomic_order`)
taxon_counts_df_2022 <- as.data.frame(taxon_counts)
taxon_counts_df_2022 <- taxon_counts_df_2022[order(-taxon_counts_df_2022$Freq), ]
songbirds2022_sp <- merge(taxon_counts_df_2022, taxon_names, by.x = "Var1", by.y = "TAXON_ORDER", all.x = TRUE) %>%
  select(Var1, Freq, PRIMARY_COM_NAME, SCI_NAME)
songbirds2022_sp <- songbirds2022_sp[order(-songbirds2022_sp$Freq), ]
write.csv(songbirds2022_sp, "songbird_count_2022.csv")



taxon_counts <- table(songbirds2018$`taxonomic_order`)
taxon_counts_df <- as.data.frame(taxon_counts)
sorted_taxon_counts_df <- taxon_counts_df[order(-taxon_counts_df$Freq), ]
songbirds2018_sp <- merge(sorted_taxon_counts_df, taxon_names, by.x = "Var1", by.y = "TAXON_ORDER", all.x = TRUE)
songbirds2018_sp <- songbirds2018_sp[order(-songbirds2018_sp$Freq), ]
write.csv(songbirds2018_sp, "songbird_count_2018_b.csv")

taxon_counts <- table(songbirds2020$`taxonomic_order`)
taxon_counts_df <- as.data.frame(taxon_counts)
sorted_taxon_counts_df <- taxon_counts_df[order(-taxon_counts_df$Freq), ]
songbirds2020_sp <- merge(sorted_taxon_counts_df, taxon_names, by.x = "Var1", by.y = "TAXON_ORDER", all.x = TRUE)
songbirds2020_sp <- songbirds2020_sp[order(-songbirds2020_sp$Freq), ]
write.csv(songbirds2020_sp, "songbird_count_2020_b.csv")

taxon_counts <- table(songbirds2022$`taxonomic_order`)
taxon_counts_df <- as.data.frame(taxon_counts)
sorted_taxon_counts_df <- taxon_counts_df[order(-taxon_counts_df$Freq), ]
songbirds2022_sp <- merge(sorted_taxon_counts_df, taxon_names, by.x = "Var1", by.y = "TAXON_ORDER", all.x = TRUE)
songbirds2022_sp <- songbirds2022_sp[order(-songbirds2022_sp$Freq), ]
write.csv(songbirds2022_sp, "songbird_count_2022_b.csv")



combined2018 <- songbirds2018[, c("taxonomic_order", "common_name", "scientific_name", "observation_count", "locality", "latitude", "longitude", "observation_date", "all_species_reported", "trip_comments", "species_comments")]
combined2018 <- combined2018 %>% left_join(songbirds2018_sp %>% select("SPECIES_GROUP", "ORDER1", "FAMILY", "SCI_NAME"), by = c("scientific_name" = "SCI_NAME"))
write.csv(combined2018, "songbird_count_2018.csv")

combined2020 <- songbirds2020[, c("taxonomic_order", "common_name", "scientific_name", "observation_count", "locality", "latitude", "longitude", "observation_date", "all_species_reported", "trip_comments", "species_comments")]
combined2020 <- combined2020 %>% left_join(songbirds2020_sp %>% select("SPECIES_GROUP", "ORDER1", "FAMILY", "SCI_NAME"), by = c("scientific_name" = "SCI_NAME"))
write.csv(combined2020, "songbird_count_2020.csv")

combined2022 <- songbirds2022[, c("taxonomic_order", "common_name", "scientific_name", "observation_count", "locality", "latitude", "longitude", "observation_date", "all_species_reported", "trip_comments", "species_comments")]
combined2022 <- combined2022 %>% left_join(songbirds2022_sp %>% select("SPECIES_GROUP", "ORDER1", "FAMILY", "SCI_NAME"), by = c("scientific_name" = "SCI_NAME"))
write.csv(combined2022, "songbird_count_2022.csv")



songbirds2018_sp <- subset(songbirds2018_sp, songbirds2018_sp$CATEGORY!='spuh')
songbirds2018_sp_columns <- select(songbirds2018_sp, -c(Var1, SPECIES_CODE, REPORT_AS))
write.csv(songbirds2018_sp_columns, "songbird_aggregated_2018.csv", row.names=FALSE)

songbirds2020_sp <- subset(songbirds2020_sp, songbirds2020_sp$CATEGORY!='spuh')
songbirds2020_sp_columns <- select(songbirds2020_sp, -c(Var1, SPECIES_CODE, REPORT_AS))
write.csv(songbirds2020_sp_columns, "songbird_aggregated_2020.csv", row.names=FALSE)

songbirds2022_sp <- subset(songbirds2022_sp, songbirds2022_sp$CATEGORY!='spuh')
songbirds2022_sp_columns <- select(songbirds2022_sp, -c(Var1, SPECIES_CODE, REPORT_AS))
write.csv(songbirds2022_sp_columns, "songbird_aggregated_2022.csv", row.names=FALSE)
