#!/bin/bash

# Test script for ssh-wunderbar
# Runs ssh-wunderbar in test mode without affecting real SSH setup

echo "🧪 ssh-wunderbar Test Mode"
echo "========================="
echo ""
echo "This will test ssh-wunderbar without modifying your real SSH configuration."
echo "All files will be created in: $(pwd)/test-output/"
echo ""

# Clean previous test only if --clean flag is used
if [ "$1" = "--clean" ]; then
    if [ -d "test-output" ]; then
        echo "🧹 Cleaning previous test output..."
        rm -rf test-output
    fi
    shift # Remove --clean from arguments
fi

# Set test mode environment variable
export SSH_WUNDERBAR_TEST_MODE=true

echo "🚀 Starting ssh-wunderbar in test mode..."
echo ""

# Run ssh-wunderbar
./ssh-wunderbar "$@"

echo ""
echo "🧪 Test completed!"
echo ""
echo "📁 Test results in: $(pwd)/test-output/"
if [ -d "test-output" ]; then
    echo "📋 Generated files:"
    find test-output -type f | sed 's/^/  /'
    
    if [ -f "test-output/operations.log" ]; then
        echo ""
        echo "📝 Operations log:"
        cat test-output/operations.log | sed 's/^/  /'
    fi
fi