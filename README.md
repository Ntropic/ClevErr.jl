# ClevErr.jl

[![Build Status](https://github.com/Ntropic/ClevErr.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Ntropic/ClevErr.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**ClevErr.jl** gives audible feedback about program execution. Itprovides a monkey patch for Julia's `Base.error` function, informing the user about an error occuring. 
It furthermore adds the functions `celebrate` and `done`, which are used equivalently to `println`, but additionally playing an informative sound. 

## Installation
Install it using 
```julia
using Pkg
Pkg.add("ClevErr")
```
## Usage 
Simply call `error` as usual, and the notification sound will play when an error occurs. 
Similarly call `celebrate("Some message ", some variables...)` or `done("Some message", some variables...)`, and the notification sound will play `while the message is printed. 
Audio output does not block code execution. 

You can change the volume via a call to `set_volume(value)` (using values between 0 and 1). The volume is stored persistently as a default for your `CevErr` installation.

## Authors
- [Michael Schilling](https://github.com/Ntropic)
