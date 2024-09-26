# CAPSE-Cyclostationary_CNN

# Underwater Acoustic Target Classification using CAPSE and Cyclostationary Features with CNN

## Overview
This repository implements a novel framework for **underwater acoustic target classification** using **Coherently Averaged Power Spectrum Estimation (CAPSE)** and **Cyclostationary Feature Extraction** integrated with a **Convolutional Neural Network (CNN)**. The model efficiently handles ship-radiated noise, even in low signal-to-noise ratio (SNR) environments, providing robust classification performance.

## Features
- **CAPSE Feature Extraction**: Enhances the spectral clarity of noisy acoustic signals.
- **Cyclostationary Analysis**: Captures periodic features (e.g., propeller noise) from ship-radiated noise.
- **CNN Architecture**: Optimized for learning and classifying the extracted features.
- Benchmarking on **ShipsEar** and **DeepShip** datasets.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/username/underwater-acoustic-classification.git
