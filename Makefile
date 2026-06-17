.PHONY: help test lint clean install

NAME := ignisky-spark

help:           ## Muestra esta ayuda
	@grep -E '^[a-zA-Z_-]+:.*##' Makefile | sort | awk 'BEGIN {FS = ":.*## "}; {printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

test:           ## Ejecuta smoke test completo
	@bash -n $(NAME).sh && echo "✅ Syntax OK"
	@SPARK_WORKDIR=/tmp bash $(NAME).sh --type python --name spark-test --author Test --desc test >/dev/null 2>&1 && \
	  rm -rf /tmp/spark-test && echo "✅ Smoke OK"

lint:           ## ShellCheck
	shellcheck --severity=style $(NAME).sh

install:        ## Instala en ~/.local/bin
	@mkdir -p $(HOME)/.local/bin
	cp $(NAME).sh $(HOME)/.local/bin/$(NAME)
	chmod +x $(HOME)/.local/bin/$(NAME)
	@echo "✅ ignisky-spark instalado en ~/.local/bin/$(NAME)"

clean:          ## Limpia temporales
	rm -rf /tmp/spark-*

.PHONY: help test lint install clean
