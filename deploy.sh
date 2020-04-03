docker build -t stevejohansson/multi-client:latest -t stevejohansson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stevejohansson/multi-server:latest -t stevejohansson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stevejohansson/multi-worker:latest -t stevejohansson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stevejohansson/multi-client:latest
docker push stevejohansson/multi-server:latest
docker push stevejohansson/multi-worker:latest

docker push stevejohansson/multi-client:$SHA
docker push stevejohansson/multi-server:$SHA
docker push stevejohansson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stevejohansson/multi-server:$SHA
kubectl set image deployments/client-deployment client=stevejohansson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stevejohansson/multi-worker:$SHA