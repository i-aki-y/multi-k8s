docker build -t akiyuki/multi-client:latest -t akiyuki/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akiyuki/multi-server:latest -t akiyuki/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akiyuki/multi-worker:latest -t akiyuki/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akiyuki/multi-client:latest
docker push akiyuki/multi-server:latest
docker push akiyuki/multi-worker:latest

docker push akiyuki/multi-client:$SHA
docker push akiyuki/multi-server:$SHA
docker push akiyuki/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akiyuki/multi-server:$SHA
kubectl set image deployments/client-deployment client=akiyuki/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akiyuki/multi-worker:$SHA
