# Spatial Python - Final Project
# **Deep Learning for Patch-based LULC Classification (Leipzig)**

- using the EuroSAT dataset to train a convolutional neural network to predict LULC classes of a new dataset
- via transfer learning the CNN model is pre-trained on the EuroSAT (labeled 64x64m Sentinel 2 tiles) and then applied to classif the LULC of the city of Leipzig


**Author:** Caroline Busse (September 2021)

## **Script Structure**
# 0. Download EuroSAT data
# 1. Data Exploration of EuroSAT dataset
# 2. Pre-Processing of image tiles
# 3. Model Building
# 4. Accuracy Assessment
# 5. Transfer Learning: apply pre-trained model to new data (unlabeled Sentinel-2 64x64m tiles in city of Leipzig) to predict their LULC class
# 6. Validation of the predicted LULC classes via field data collected in Leipzig
# 7. Research Outcome

## **Sources:**
#[1] Eurosat: A novel dataset and deep learning benchmark for land use and land cover classification. Patrick Helber, Benjamin Bischke, Andreas Dengel, Damian Borth. IEEE Journal of Selected Topics in Applied Earth Observations and Remote Sensing, 2019.
#[2] Introducing EuroSAT: A Novel Dataset and Deep Learning Benchmark for Land Use and Land Cover Classification. Patrick Helber, Benjamin Bischke, Andreas Dengel. 2018 IEEE International Geoscience and Remote Sensing Symposium, 2018.

