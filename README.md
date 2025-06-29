# 📍 Data Ecology in UK Tech Hubs

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/license-CC--BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
[![R Version](https://img.shields.io/badge/built%20with-R-blue.svg)](https://www.r-project.org/)

## 🔍 Overview

This repository presents a geospatial and strategic analysis of **data ecology in UK tech clusters**, focusing on **London** and **Manchester**. It includes an academic presentation and an R script used to generate maps, interactive visuals, and summary tables. The work supports stakeholders interested in tech cluster development, innovation ecosystems, and post-COVID digital strategies.

---

## 📁 Repository Contents

### 📄 `Data Ecology in UK Tech Hubs.pdf`
A 12-slide professional presentation covering:
- Geographic distribution of tech clusters in the UK  
- Cluster deep dives: **London** vs **Manchester**  
- Startups’ role in big data, AI, and sustainability  
- Ecosystem infrastructure and socioeconomic impact  
- Strategic implementation in a post-pandemic world  

### 📜 `UK MAPS.R`
A fully annotated R script for generating:
- A static **UK tech hubs map** (`UK_Tech_Hubs_Map.png`)  
- Interactive **cluster maps** for London and Manchester  
- A **summary table** (input: `ManLon.xlsx`, output: `ManLon_Table.html`)

📌 Technologies used:
- **Mapping**: `sf`, `rnaturalearth`, `ggplot2`, `mapview`, `leafpop`  
- **Tabulation**: `reactablefmtr`, `readxl`  
- **Enhancement**: `ggrepel`, `scales`, `theme_void`

---

## 🗺️ Features in the Map

- 📍 Cities plotted by **tech activity score** (scale 1–10)  
- 🏷️ Specializations labeled (e.g., FinTech, Life Sciences, AI)  
- 🎨 Hubs categorized into:
  - 🟥 **Primary** (e.g., London, Reading)
  - 🟦 **Secondary** (e.g., Birmingham, Basingstoke)
  - 🟩 **Emerging** (e.g., Liverpool, Leeds)

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/RProDigest/DataEcology-text.git
cd DataEcology-text
```

### 2. Open RStudio
- Open the `UK MAPS.R` script.
- Make sure `ManLon.xlsx` is in your working directory.
- Run the script to generate:
  - `UK_Tech_Hubs_Map.png`
  - `UK_Tech_Hubs_Table.html`

### 3. Explore the Presentation
- Open `Data Ecology in UK Tech Hubs.pdf` for a strategic overview.

---

## 📚 References

All data and insights are supported by:
- [Tech Nation (2021)](https://technation.io/report2021/)  
- [Centre for Cities (2020)](https://www.centreforcities.org)  
- [Big Data London (2022)](https://bigdataldn.com)  
- [UK Digital Strategy (2021)](https://www.gov.uk/government/publications/uk-digital-strategy)  
- And more, listed in the final presentation slide.

---

## 👨‍🎓 Author

**Mubanga Nsofu**  
*UEL MSc Data Science*  
*Student ID: R2012D11689258*  
Email: [mubangansofujr@gmail.com]  
Date: **June 2025**

---

## ⚖️ License

This project is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License**.  
See the full license here: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

---

## 💡 Acknowledgments

- University of East London (UEL)  
- DS-7001: Data Ecology Module  
- Natural Earth, ONS, and R Open Source Community

---
