# Digital Image Processing Repository

Welcome to the Digital Image Processing Repository! This repository focuses on various aspects of digital image processing, providing implementations and tools for image enhancement, filtering, and analysis.

## Project Structure

- **DigitalImageProcessingRepository/**
  - `abertura.m`
  - `fechamento.m`
  - `canaisrgb.m`
  - `filtra_freq.m`
  - `meu_LoG.m`
  - `restaura_media.m`
  - `contraste.m`
  - `filtra_freq_two.m`
  - `meu_sobel.m`
  - `restaura_mediana.m`
  - `dilata.m`
  - `filtro_realce.m`
  - `Quantiza.m`
  - `ruido.m`
  - `distmat.m`
  - `filtro_suavizador.m`
  - `Quantiza_ycbcr.m`
  - `segmenta.m`
  - `erosao.m`
  - `fq.m`
  - `realce.m`
  - `suaviza.m`

- **Leukocyte-Count/**
  - **Imagens Teste/**
    - `img01.jpg`
    - `img02.jpg`
    - `img03.jpg`
    - `img04.jpg`
    - `img05.jpg`
    - `img06.jpg`
    - `img07.jpg`
    - `img08.jpg`
    - `img09.JPG`
    - `img10.JPG`
  - `leucocitos.m`
  - **Relatorio/**
    - `Relatorio.pdf`

## Leukocyte Count Project

The `LeukocyteCountProject` is a dedicated section of this repository focusing on the COUNTING AND ANALYSIS OF BLOOD CELLS using MATLAB.

### Project Description

In this project, the chosen segmentation technique is thresholding. The observation led to the identification of white blood cells, or leukocytes, having stronger shades of red in microscope images. Other red blood cells are represented by lighter regions (light purple, weak red, or pink). The segmentation is achieved by setting a threshold (delta) to identify high values in the first color channel of the RGB image, specifically the red channel (`leimgdb(:,:,1)` in the code). The goal is to eliminate the weaker tones corresponding to red blood cells, resulting in an image with only the actual leukocyte objects.

## Contributing

If you are interested in contributing to this repository, please follow our guidelines for contributions. We welcome improvements, additional scripts, or enhancements related to digital image processing.
