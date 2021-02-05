docker build jordan42/multi-client:latest -t jordan42/multi-client:$SHA -f ./client/Dockerfile ./client
docker build jordan42/multi-server:latest -t jordan42/multi-server:$SHA -f ./server/Dockerfile ./server
docker build jordan42/multi-worker:latest -t jordan42/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jordan42/multi-client:latest
docker push jordan42/multi-server:latest
docker push jordan42/multi-worker:latest

docker push jordan42/multi-client:$SHA
docker push jordan42/multi-server:$SHA
docker push jordan42/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jordan42/multi-server:$SHA
kubectl set image deployments/client-deployment server=jordan42/multi-client:$SHA
kubectl set image deployments/worker-deployment server=jordan42/multi-worker:$SHA
