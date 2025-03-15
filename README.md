# ClevErr.jl

[![Build Status](https://github.com/Ntropic/ClevErr.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Ntropic/ClevErr.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**ClevErr.jl** provides a monkey patch for Julia's `Base.error` function, allowing it to
    - To play a notification sound when an error occurs.
    - To use **ollama** to analyze the error message, to privde a summary and suggest a fix. 

This project is a work in progress. Feel free to contribute or report any issues you encounter! 🚀

## Installation
Install it using 
```julia
using Pkg
Pkg.add("ClevErr")
```
## Usage 
Simply call `error` as usual, and the notification sound will play when an error occurs. 

## Authors
- [Michael Schilling](https://github.com/Ntropic)
"# ClevErr.jl" 
