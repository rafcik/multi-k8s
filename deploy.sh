docker build -t rafcik/multi-client:latest -t rafcik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rafcik/multi-server:latest -t rafcik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rafcik/multi-worker:latest -t rafcik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rafcik/multi-client:latest
docker push rafcik/multi-server:latest
docker push rafcik/multi-worker:latest

docker push rafcik/multi-client:$SHA
docker push rafcik/multi-server:$SHA
docker push rafcik/multi-worker:$SHA

kubectl apply -f k8s2
kubectl set image deployments/server-deployment server=rafcik/multi-server:$SHA
kubectl set image deployments/client-deployment client=rafcik/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rafcik/multi-worker:$SHA
