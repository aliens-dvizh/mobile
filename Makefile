build_runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

precommit:
	dart format .
	dart fix --apply
	flutter pub run import_sorter:main lib\/*
	flutter analyze


