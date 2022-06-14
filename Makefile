.PHONY: create_symlinks

create_symlinks:
		copy_files

prerequisites: create_symlinks

target: prerequisites
