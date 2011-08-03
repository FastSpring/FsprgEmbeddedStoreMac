export PRODUCT_NAME=$1
export CONFIGURATION=$2
export TARGET_DIR=$3

if [ ! -d "$TARGET_DIR" ]; then
	mkdir -p "$TARGET_DIR"
fi

if [[ $CONFIGURATION = "Source" ]]; then
	echo "Copy source of $PRODUCT_NAME to $TARGET_DIR"
	
	# copy src
	cp -R -f "$PRODUCT_NAME" "$TARGET_DIR"
	# remove development specific files
	rm $TARGET_DIR/$PRODUCT_NAME/$PRODUCT_NAME.xcodeproj/*.mode1v3
	rm $TARGET_DIR/$PRODUCT_NAME/$PRODUCT_NAME.xcodeproj/*.pbxuser
	# remove build directory
	rm -R -f "$TARGET_DIR/$PRODUCT_NAME/build"
	# remove .DS_Store directories
	find "$TARGET_DIR/$PRODUCT_NAME" -name .DS_Store -print0 | xargs -0 rm -rf
else
	xcodebuild -project "$PRODUCT_NAME/$PRODUCT_NAME.xcodeproj" -target "$PRODUCT_NAME" -configuration "$CONFIGURATION" clean build

	echo "Copy binaries of $PRODUCT_NAME to $TARGET_DIR"
	export APP_DIR=$PRODUCT_NAME/build/$CONFIGURATION/$PRODUCT_NAME.app
	if [ -d "$APP_DIR" ]; then
		cp -R -f "$APP_DIR" "$TARGET_DIR"
	fi
	export FRAMEWORK_DIR=$PRODUCT_NAME/build/$CONFIGURATION/$PRODUCT_NAME.framework
	if [ -d "$FRAMEWORK_DIR" ]; then
		cp -R -f "$FRAMEWORK_DIR" "$TARGET_DIR"
	fi
fi