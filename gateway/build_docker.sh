IMAGE_NAME=docker.pkg.github.com/mkdir-sweden/padpal/gateway:latest

docker build . -t $IMAGE_NAME
docker push $IMAGE_NAME