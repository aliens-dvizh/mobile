buildrunner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

precommit:
	fvm dart format .
	fvm dart fix --apply
	fvm flutter pub run import_sorter:main lib\/*
	fvm flutter analyze


