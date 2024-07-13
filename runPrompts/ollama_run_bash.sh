#!/bin/bash
# Custom startup script for ollama

# Pull the specific version
ollama pull gemma2:9b

# Run the specific version
ollama run gemma2:9b

# Keep the container running (if needed)
tail -f /dev/null