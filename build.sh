#!/bin/bash

docker build -t=graphlab --build-arg "USER_EMAIL=genius@example.edu" --build-arg "USER_KEY=ABCD-0123-EF45-6789-9876-54FE-3210-DCBA" .
