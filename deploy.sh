docker build -t felipeparreirafb/multi-client:latest -f ./client/Dockerfile -t felipeparreirafb/multi-client:$SHA ./client
docker build -t felipeparreirafb/multi-server:latest -f ./server/Dockerfile -t felipeparreirafb/multi-server:$SHA ./server
docker build -t felipeparreirafb/multi-worker:latest -f ./worker/Dockerfile -t felipeparreirafb/multi-worker:$SHA ./worker
docker push felipeparreirafb/multi-client:latest
docker push felipeparreirafb/multi-client:$SHA
docker push felipeparreirafb/multi-server:$SHA
docker push felipeparreirafb/multi-worker:$SHA
docker push felipeparreirafb/multi-server:latest
docker push felipeparreirafb/multi-worker:latest
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=felipeparreirafb/multi-server:$SHA
kubectl set image deployments/server-deployment server=felipeparreirafb/multi-client:$SHA
kubectl set image deployments/server-deployment server=felipeparreirafb/multi-worker:$SHA