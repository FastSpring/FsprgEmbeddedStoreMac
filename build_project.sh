export PRODUCT_NAME=$1
export CONFIGURATION=$2
export TARGET_DIR=$3
export COPY_SRC=$4

xcodebuild -project $PRODUCT_NAME/$PRODUCT_NAME.xcodeproj -target $PRODUCT_NAME -configuration $CONFIGURATION clean build

echo "Copy binaries to $TARGET_DIR"
if [ ! -d "$TARGET_DIR" ]; then
	mkdir $TARGET_DIR
fi
export APP_DIR=$PRODUCT_NAME/build/$CONFIGURATION/$PRODUCT_NAME.app
if [ -d "$APP_DIR" ]; then
	cp -R -f $APP_DIR $TARGET_DIR
fi
export FRAMEWORK_DIR=$PRODUCT_NAME/build/$CONFIGURATION/$PRODUCT_NAME.framework
if [ -d "$FRAMEWORK_DIR" ]; then
	cp -R -f $FRAMEWORK_DIR $TARGET_DIR
fi

if [[ $COPY_SRC ]]; then
	export TARGET_SRC_DIR=$TARGET_DIR/src
	echo "Copy source to $TARGET_SRC_DIR"
	if [ ! -d "$TARGET_SRC_DIR" ]; then
		mkdir $TARGET_SRC_DIR
	fi
	
	# copy src
	cp -R -f $PRODUCT_NAME $TARGET_SRC_DIR
	# remove build directory
	rm -R -f $TARGET_SRC_DIR/$PRODUCT_NAME/build
	# remove .svn directories
	find $TARGET_SRC_DIR/$PRODUCT_NAME -name .svn -print0 | xargs -0 rm -rf
	# remove .DS_Store directories
	find $TARGET_SRC_DIR/$PRODUCT_NAME -name .DS_Store -print0 | xargs -0 rm -rf
fi