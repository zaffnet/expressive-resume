# Agent Instructions

This document provides instructions for an automated agent operating within the pre-configured project environment.

## Goal

The primary goal is to compile the LaTeX source files to generate `resume.pdf`.

## Environment

The agent is running in an environment where all necessary dependencies (TeX Live, fonts, etc.) are already installed and cached.

## Command to Generate PDF

To generate the PDF, the agent must execute the following command from the `src/` directory:

```bash
latexmk -xelatex resume.tex
```

This command will create or update the `resume.pdf` file in the current directory (`src/`).
