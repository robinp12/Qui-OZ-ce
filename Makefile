OZC = ozc
OZENGINE = ozengine

DBPATH= database.txt
ANSWERFILE= test_answers.txt
NOGUI= "--nogui" # set this variable to --nogui if you don't want the GUI

SRC=$(wildcard *.oz)
OBJ=$(SRC:.oz=.ozf)

OZFLAGS = --nowarnunused

all: $(OBJ)

run: all
	@echo RUN main.ozf
	@$(OZENGINE) main.ozf --ans $(ANSWERFILE) --db $(DBPATH) $(NOGUI)

%.ozf: %.oz
	@echo OZC $@
	@$(OZC) $(OZFLAGS) -c $< -o $@
	ozengine .\main.ozf

.PHONY: clean

clean:
	@echo rm $(OBJ)
	@rm -rf $(OBJ)
