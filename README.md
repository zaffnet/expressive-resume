# Expressive Resume and Cover Letter Template

This repository contains a LaTeX template for creating an expressive and modern resume and cover letter.

## Generating the PDF

The resume is compiled using a Docker-based workflow, which ensures a consistent and hassle-free environment.

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) must be installed on your system.

### Instructions

1.  **Make the setup script executable:**
    ```bash
    chmod +x setup.sh
    ```

2.  **Run the setup script:**
    ```bash
    ./setup.sh
    ```

That's it! The script will automatically pull the `thubo/latexmk` Docker image, mount your project directory, and compile `src/resume.tex`. The final `resume.pdf` will be generated in the `src` directory.