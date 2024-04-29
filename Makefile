all:
	ln -s "$$(pwd)/.bashrc" "$$HOME/.bashrc"

force:
	ln -sf "$$(pwd)/.bashrc" "$$HOME/.bashrc"

.PHONY: all force
