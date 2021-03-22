docker build -t igornovitsky/multi-client:latest -t igornovitsky/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t igornovitsky/multi-server:latest -t igornovitsky/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t igornovitsky/multi-worker:latest -t igornovitsky/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push igornovitsky/multi-client:latest
docker push igornovitsky/multi-server:latest
docker push igornovitsky/multi-worker:latest

docker push igornovitsky/multi-client:$SHA
docker push igornovitsky/multi-server:$SHA
docker push igornovitsky/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=igornovitsky/multi-server:$SHA
kubectl set image deployments/client-deployment client=igornovitsky/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=igornovitsky/multi-worker:$SHA