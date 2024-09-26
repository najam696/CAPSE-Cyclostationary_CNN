# CAPSE-Cyclostationary_CNN

Underwater Acoustic Target Classification with CAPSE and Cyclostationary Features using CNN
Overview
This repository contains the implementation of a novel underwater acoustic target classification framework that leverages Coherently Averaged Power Spectrum Estimation (CAPSE) and Cyclostationary Feature Extraction, integrated with a Convolutional Neural Network (CNN). The framework is designed to classify ship-radiated noise, particularly effective in low signal-to-noise ratio (SNR) environments. It uses features that are derived from CAPSE and cyclostationary analysis to capture the periodic characteristics of ship signals and improve classification accuracy.

Repository Contents
Code: The code for implementing the CNN architecture, CAPSE, and cyclostationary feature extraction.
Datasets: Contains the preprocessed ShipsEar and DeepShip datasets used for training and testing.
Notebooks: Jupyter notebooks for detailed experimentation and visualization of results.
Scripts: Python scripts for dataset processing, training, evaluation, and performance benchmarking.
Features
CAPSE-based Feature Extraction: Enhances spectral resolution and clarity.
Cyclostationary Analysis: Extracts periodic features inherent in ship-radiated noise, such as propeller noise.
CNN for Classification: Optimized network architecture for high classification accuracy.
Dataset Support: Code to handle both ShipsEar and DeepShip datasets.
