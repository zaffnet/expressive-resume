#
# This script compiles the resume.tex file into a PDF using the thubo/latexmk Docker image.

# --- Exit on Error ---
set -e

# --- Build the Resume ---
echo "Building the resume using Docker..."
docker run --rm -v "$(pwd)":/data thubo/latexmk -output-directory=src -xelatex src/resume.tex

# --- Clean up auxiliary files ---
echo "Cleaning up auxiliary files..."
docker run --rm -v "$(pwd)":/data thubo/latexmk -c -output-directory=src src/resume.tex

echo "Setup complete. The PDF should be generated in the src/ directory as resume.pdf"
