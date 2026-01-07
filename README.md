![MATLAB](https://img.shields.io/badge/language-MATLAB-blue)

# CPD-Deblur

This repository provides the **official MATLAB implementation** of the method proposed in:

**Fast Image Deblurring Based on Cross Partial Derivative**  

Published in **IEEE Transactions on Image Processing (TIP)**.  

DOI: https://doi.org/10.1109/TIP.2025.3645574

---

## 🔍 Highlights
- Fast blind image deblurring using **Cross Partial Derivative (CPD)** statistics
- Robust blur kernel estimation
- Lightweight MATLAB implementation (no deep learning)
- Suitable for research and benchmarking purposes
- 📌 Blind kernel estimation using CPD features  
- ⚡ Fast computation — CPU friendly (only a few seconds)
- 📈 Works on real and synthetic motion-blurred images  

---

## Requirements

- MATLAB (recommended: R2019a or later)

If you encounter missing function errors, please ensure the repository folder and its subfolders are added to the MATLAB path.

---

## Quick Start

1. Clone this repository:
git clone https://github.com/e11tkcee06-a11y/CPD-Deblur.git

2. In MATLAB, set the current folder to the repository root (the folder containing `Demo_CPD_v01.m`).

3. Run the demo:
Demo_CPD_v01

This demo script demonstrates the full pipeline, including **blur kernel estimation** and **image deblurring** using the proposed CPD-based method.

---

## Repository Structure

CPD-Deblur/

- Function --- Sub-functions for CPD and kernel estimation

- Parameter --- Parameter settings (Excel format)
  
- Test Image --- Demo test images
  
- Demo_CPD_v01.m --- Main executable script
  
- f_00_Estimate_Kernel.m --- Main function: Estimate kernel
  
- f_00_Reconstruct_Image.m --- Main function: Non-blind deconvolution

---

## Notes

- The default parameters in the demo are set according to the experimental configuration described in the paper.
- For fair comparison with other methods, please follow the evaluation protocol reported in the IEEE TIP article.

---

## Citation

If you use this code in your research, please cite the following paper:

@ARTICLE{11313782,<br>
  author={Ting, Kuan-Chung and Wang, Sheng-Jyh and Hwang, Ruey-Bing},<br>
  journal={IEEE Transactions on Image Processing}, <br>
  title={Fast Blind Image Deblurring Based on Cross Partial Derivative}, <br>
  year={2025},<br>
  volume={34},<br>
  pages={8627-8640},<br>
  doi={10.1109/TIP.2025.3645574}<br>
  }

---

## Scope / License

This code is provided for **academic and research purposes**.
If you find this repository useful, please consider starring it to support the work.

---

## History

- **Paper timeline (IEEE Transactions on Image Processing)**  
  Received: 16 June 2025  
  Revised: 23 October 2025  
  Accepted: 11 December 2025  
  Date of publication: 23 December 2025  
  Current version: 29 December 2025  

- **Release .m file of sub-functions**  
  Release date: 08 January 2026

