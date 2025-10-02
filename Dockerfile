# Use the official OpenAI Codex Universal image as a base
FROM ghcr.io/openai/codex-universal:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project directory into the container
COPY . .

# Run the setup script to install all dependencies.
# This is done during the image build process.
RUN chmod +x ./setup.sh && ./setup.sh

# Set the default command to generate the resume PDF.
# This will be executed when a container is run.
WORKDIR /app/src
CMD ["latexmk", "-xelatex", "resume.tex"]