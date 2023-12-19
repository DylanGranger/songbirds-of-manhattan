# Songbirds of Manhattan Through the COVID-19 Pandemic

This project is an analysis and mapping of songbird sightings in Manhattan during the Spring over three years - 2018, 2020, and 2022 using sighting data from eBird, conducted by Gabriella Evergreen and Dylan Granger. The purpose of this analysis was to determine if there were noticeable differences in population counts or distribution of species before and after the 2020 Covid pandemic. The results of this study (including the maps themselves) can be found on [this storymaps page](https://storymaps.arcgis.com/stories/b97d8320ceb7413e9db2b8ebb0868741). This repository contains the R script that was used to filter and sort data from eBird as well as instructions on how to replicate this process.

![Story Map](https://github.com/DylanGranger/songbirds-of-manhattan/blob/main/storymap_screenshot.png)

# Initial Download
This project makes use of data from [eBird](https://science.ebird.org/en), a crowdsourced compendium of bird sightings organized and maintained by the Cornell Lab of Ornithology. eBird allows users to download their data for research purposes as long as they sign up for a Cornell Lab account first. The basic eBird dataset is used for this project. Our initial download was completed with the following filter options:

1. Species: All species
2. Region: New York, New York, United States (US)
3. Date Range: From January 2018 to September 2023
  * **NOTE**: This range was used before we had decided on our exact parameters for dates within our project. Later on this range is narrowed down further in R. In theory this download could be three separate downloads of April 2018/2020/2022 to May 2018/2020/2022, reducing the size of the download and initial file, but this would also require re-working of the R script used for filtering.
4. Options: "YES" to including sampling event data, "NO" to including unvetted data.

After completing this download, the file should be saved to whatever directory will serve as the working directory for R.

In addition to sighting data from eBird, this project also requires the use of eBird's taxonomy spreadsheet, which is used to filter bird species by the family they belong to. [The spreadsheet can be downloaded here](https://www.birds.cornell.edu/clementschecklist/introduction/updateindex/october-2023/download/). It is important to note that the initial data for this project was downloaded before the October 2023 update to the spreadsheet, and so it used the 2022 version instead. With each update the taxon numbering is changed, and these numbers must match up to whichever numbers are present in the actual data. If you are looking at this project after October 2024 you may have to use a newer version of the taxonomy spreadsheet.

# Filtering the Data
The provided R file songbird_filtering.r is used to filter the data set into the aggregated data which we used for our mappings. The file itself is annotated to explain its processes. In essence it filters the dataset down to bird species which belong to the Passeriformes (songbird) family, and then filters the sightings into the three date ranges (Spring 2018, 2020, and 2022). It then outputs several sets of CSVs for each year:

1. **songbirdsYEAR.csv**: Includes every sighting as a separate row, with every original variable from the eBird dataset.
2. **songbird_count_YEAR**: Includes the same rows as songbirdsYEAR, but with many superfluous variables removed.
3. **songbird_aggregated_YEAR**: Instead of each row representing a sighting, each row is a different species of songbird. The first column is the total number of that species seen during the relevant time period.

eBird asks researchers not to publish or distribute eBird data in its original format, so these spreadsheets are not directly linked on this repository. Sample spreadsheets are included that have the same variable/column names and a few rows of example data for demonstration purposes.
