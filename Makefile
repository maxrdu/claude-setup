# Claude Code Configuration Manager
#
# Manages symlinks from this repository into ~/.claude/
# Creates individual symlinks for each skill, agent, command, etc.
# so third-party additions can coexist without polluting this repo.
#
# Usage:
#   make install    - Create symlinks in ~/.claude/
#   make uninstall  - Remove only symlinks managed by this repo
#   make status     - Show managed vs. third-party items
#   make clean      - Alias for uninstall
#   make help       - Show this help

SHELL := /bin/bash

# Directories
SRC_DIR  := $(shell pwd)
DEST_DIR := $(HOME)/.claude

# Managed top-level directories (each item inside gets its own symlink)
MANAGED_DIRS := skills agents commands docs scripts output-styles

# Individual files to symlink at the root of ~/.claude/
MANAGED_FILES := CLAUDE.md

.PHONY: install uninstall status clean help dirs

help: ## Show available targets
	@echo "Claude Code Configuration Manager"
	@echo ""
	@echo "Usage:"
	@echo "  make install    Create symlinks in ~/.claude/"
	@echo "  make uninstall  Remove only managed symlinks"
	@echo "  make status     Show managed vs. third-party items"
	@echo "  make clean      Remove all managed symlinks"
	@echo "  make help       Show this help"
	@echo ""
	@echo "Symlinks are created per-item (not per-directory) so that"
	@echo "third-party skills, agents, etc. can coexist alongside yours."

dirs: ## Create target directories if needed
	@for dir in $(MANAGED_DIRS); do \
		mkdir -p "$(DEST_DIR)/$$dir"; \
	done

install: dirs ## Create symlinks in ~/.claude/
	@echo "Installing claude-setup into $(DEST_DIR)..."
	@echo ""
	@# Symlink individual items inside each managed directory
	@for dir in $(MANAGED_DIRS); do \
		if [ -d "$(SRC_DIR)/$$dir" ]; then \
			for item in "$(SRC_DIR)/$$dir"/*; do \
				[ -e "$$item" ] || continue; \
				name=$$(basename "$$item"); \
				target="$(DEST_DIR)/$$dir/$$name"; \
				if [ -L "$$target" ]; then \
					echo "  skip  $$dir/$$name (symlink exists)"; \
				elif [ -e "$$target" ]; then \
					echo "  WARN  $$dir/$$name (file exists, not overwriting)"; \
				else \
					ln -s "$$item" "$$target"; \
					echo "  link  $$dir/$$name"; \
				fi; \
			done; \
		fi; \
	done
	@# Symlink individual root-level files
	@for file in $(MANAGED_FILES); do \
		if [ -f "$(SRC_DIR)/$$file" ]; then \
			target="$(DEST_DIR)/$$file"; \
			if [ -L "$$target" ]; then \
				echo "  skip  $$file (symlink exists)"; \
			elif [ -e "$$target" ]; then \
				echo "  WARN  $$file (file exists, not overwriting)"; \
			else \
				ln -s "$(SRC_DIR)/$$file" "$$target"; \
				echo "  link  $$file"; \
			fi; \
		fi; \
	done
	@echo ""
	@echo "Done. Run 'make status' to verify."

uninstall: ## Remove only symlinks pointing to this repo
	@echo "Uninstalling managed symlinks from $(DEST_DIR)..."
	@echo ""
	@for dir in $(MANAGED_DIRS); do \
		if [ -d "$(DEST_DIR)/$$dir" ]; then \
			for item in "$(DEST_DIR)/$$dir"/*; do \
				[ -L "$$item" ] || continue; \
				link_target=$$(readlink "$$item"); \
				case "$$link_target" in \
					$(SRC_DIR)/*) \
						rm "$$item"; \
						echo "  removed  $$(basename $$item) from $$dir/"; \
						;; \
				esac; \
			done; \
		fi; \
	done
	@for file in $(MANAGED_FILES); do \
		target="$(DEST_DIR)/$$file"; \
		if [ -L "$$target" ]; then \
			link_target=$$(readlink "$$target"); \
			case "$$link_target" in \
				$(SRC_DIR)/*) \
					rm "$$target"; \
					echo "  removed  $$file"; \
					;; \
			esac; \
		fi; \
	done
	@echo ""
	@echo "Done. Third-party items were preserved."

status: ## Show managed vs. third-party items
	@echo "Claude Code Configuration Status"
	@echo "================================"
	@echo ""
	@echo "Source: $(SRC_DIR)"
	@echo "Target: $(DEST_DIR)"
	@echo ""
	@for dir in $(MANAGED_DIRS); do \
		if [ -d "$(DEST_DIR)/$$dir" ]; then \
			echo "$$dir/:"; \
			has_items=false; \
			for item in "$(DEST_DIR)/$$dir"/*; do \
				[ -e "$$item" ] || [ -L "$$item" ] || continue; \
				has_items=true; \
				name=$$(basename "$$item"); \
				if [ -L "$$item" ]; then \
					link_target=$$(readlink "$$item"); \
					case "$$link_target" in \
						$(SRC_DIR)/*) \
							echo "  [managed]      $$name -> $$link_target"; \
							;; \
						*) \
							echo "  [third-party]  $$name -> $$link_target"; \
							;; \
					esac; \
				else \
					echo "  [third-party]  $$name (local)"; \
				fi; \
			done; \
			if [ "$$has_items" = false ]; then \
				echo "  (empty)"; \
			fi; \
			echo ""; \
		fi; \
	done
	@# Root-level files
	@echo "root files:"; \
	for file in $(MANAGED_FILES); do \
		target="$(DEST_DIR)/$$file"; \
		if [ -L "$$target" ]; then \
			link_target=$$(readlink "$$target"); \
			case "$$link_target" in \
				$(SRC_DIR)/*) \
					echo "  [managed]      $$file -> $$link_target"; \
					;; \
				*) \
					echo "  [third-party]  $$file -> $$link_target"; \
					;; \
			esac; \
		elif [ -e "$$target" ]; then \
			echo "  [third-party]  $$file (local)"; \
		else \
			echo "  [missing]      $$file (run 'make install')"; \
		fi; \
	done

clean: uninstall ## Alias for uninstall
