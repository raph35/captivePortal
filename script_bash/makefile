# This makefile will compile the program of managing system firewall
# Script by Raphael

# Configuration of compilation
CC=g++
CFLAG=-Wall

# Some configurations
INCLUDE_DIR=include
SRC_DIR=src
OBJ_DIR=.
OUTPUT_DIR=.

SRC=$(wildcard $(SRC_DIR)/*.cpp)
_OBJ=$(SRC:.cpp=.o)
OBJ=$(subst $(SRC_DIR),$(OBJ_DIR),$(_OBJ))

