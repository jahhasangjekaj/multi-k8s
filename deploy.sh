docker build -t jahhasangjekaj/multi-client:latest -t jahhasangjekaj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jahhasangjekaj/multi-server:latest -t jahhasangjekaj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jahhasangjekaj/multi-worker:latest -t jahhasangjekaj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jahhasangjekaj/multi-client:latest
docker push jahhasangjekaj/multi-server:latest
docker push jahhasangjekaj/multi-worker:latest

docker push jahhasangjekaj/multi-client:$SHA
docker push jahhasangjekaj/multi-server:$SHA
docker push jahhasangjekaj/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jahhasangjekaj/multi-client:$SHA
kubectl set image deployments/server-deployment server=jahhasangjekaj/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jahhasangjekaj/multi-worker:$SHA