# Expressive Resume and Cover Letter Template

This repository contains a LaTeX template for creating an expressive and modern resume and cover letter.

## Generating the PDF

There are two ways to generate the PDF from the LaTeX source files.

### 1. Using Docker (Recommended)

This is the easiest method as it ensures a consistent environment with all dependencies pre-installed.

**Prerequisites:**
- Docker must be installed on your system.

**Steps:**

1.  **Build the Docker image:**

    Open your terminal and navigate to the root of this repository. Run the following command to build the Docker image. This step installs all necessary dependencies and may take a few minutes.

    ```bash
    docker build -t expressive-resume .
    ```

2.  **Generate the PDF:**

    Once the image is built, you can generate the PDF by running a container. The following command mounts your local `src` directory into the container, runs the LaTeX compilation process, and outputs the `resume.pdf` back into your local `src` directory.

    ```bash
    docker run --rm -v "$(pwd)/src:/app/src" expressive-resume
    ```

    After the command finishes, you will find the generated `resume.pdf` inside the `src` directory. If you make changes to your `.tex` files, you can simply run this command again to regenerate the PDF.

### 2. Local Compilation

If you have a local LaTeX distribution, you can use the provided setup script to install the necessary dependencies and compile the resume.

1.  **Run the setup script:**

    Make sure the script is executable, then run it:

    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

    This will install all required packages and fonts (requires `sudo` permissions) and then compile the document, creating `resume.pdf` in the `src` directory.