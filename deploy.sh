docker build -t dysphar/multi-client:latest -t dysphar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dysphar/multi-server:latest -t dysphar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dysphar/multi-worker:latest -t dysphar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dysphar/multi-client:latest
docker push dysphar/multi-server:latest
docker push dysphar/multi-worker:latest

docker push dysphar/multi-client:$SHA
docker push dysphar/multi-server:$SHA
docker push dysphar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dysphar/multi-server:$SHA
kubectl set image deployments/client-deployment client=dysphar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dysphar/multi-worker:$SHA
