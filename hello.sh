#!/bin/bash

echo " Running first shell script "

echo "Hello from the server!"
echo "Current date and time:"
date

mkdir -p SDS26
cd SDS26

echo "Hi, you successfully ran the first shell script!!!" > hello.txt
echo "Run at: $(date)" >> hello.txt

echo "=== Done ==="
echo "Check file: $(pwd)/hello.txt"