BUILD_DATE=20210622
VERSION=4.0.0-beta-2
NAMESPACE=local-seleniarm
AUTHORS=james

cd ./Base && docker buildx build --platform linux/arm64 -t $NAMESPACE/base:$VERSION-$BUILD_DATE .
echo $PWD
cd ../Hub && sh generate.sh $VERSION-$BUILD_DATE $NAMESPACE $AUTHORS \
   && docker buildx build --platform linux/arm64 -t $NAMESPACE/hub:$VERSION-$BUILD_DATE .

cd ../NodeBase && sh generate.sh $VERSION-$BUILD_DATE $NAMESPACE $AUTHORS \
   && docker buildx build --platform linux/arm64 -t $NAMESPACE/node-base:$VERSION-$BUILD_DATE .

cd ../NodeChromium && sh generate.sh $VERSION-$BUILD_DATE $NAMESPACE $AUTHORS \
   && docker buildx build --platform linux/arm64 -t $NAMESPACE/node-chromium:$VERSION-$BUILD_DATE .

cd ../Standalone && sh generate.sh StandaloneChromium node-chromium $VERSION-$BUILD_DATE $NAMESPACE $AUTHORS \
   && cd ../StandaloneChromium \
   && docker buildx build --platform linux/arm64 -t $NAMESPACE/standalone-chromium:$VERSION-$BUILD_DATE .

echo "Build node-hub, node-chromium, and standalone-chromium...\n"
