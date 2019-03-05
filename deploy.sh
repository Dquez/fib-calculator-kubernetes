docker build -t dquez/multi-client:latest -t dquez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dquez/multi-api:latest -t dquez/multi-api:$SHA -f ./api/Dockerfile ./api
docker build -t dquez/multi-worker:latest -t dquez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dquez/multi-client:latest
docker push dquez/multi-api:latest
docker push dquez/multi-worker:latest

docker push dquez/multi-client:$SHA
docker push dquez/multi-api:$SHA
docker push dquez/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/api-deployment api=dquez/multi-api:$SHA
kubectl set image deployments/client-deployment client=dquez/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dquez/multi-worker:$SHA