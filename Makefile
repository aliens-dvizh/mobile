build_runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

pre_push:
	dart format . && dart fix --apply && flutter analyze