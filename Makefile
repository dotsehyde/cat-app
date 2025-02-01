clean:
	flutter clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods
	flutter pub get
	cd ios && pod install

gen-trans:
	dart run easy_localization:generate -S "assets/translations" -O "lib/translations"
	dart run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

deploy-android:
	@echo "╠ Sending Android Build to Internal Testing..."
	cd android && bundle install
	cd android/fastlane && bundle exec fastlane deploy

deploy-ios:
	@echo "╠ Sending iOS Build to TestFlight..."
	cd ios/fastlane && bundle install
	cd ios/fastlane && bundle exec fastlane deploy

deploy: test deploy-android deploy-ios deploy-web

.PHONY: test clean deploy-android deploy-ios deploy-web deploy