docker build -t jhasangjekaj/multi-client:latest -t jhasangjekaj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jhasangjekaj/multi-server:latest -t jhasangjekaj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jhasangjekaj/multi-worker:latest -t jhasangjekaj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jhasangjekaj/multi-client:latest
docker push jhasangjekaj/multi-server:latest
docker push jhasangjekaj/multi-worker:latest

docker push jhasangjekaj/multi-client:$SHA
docker push jhasangjekaj/multi-server:$SHA
docker push jhasangjekaj/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jhasangjekaj/multi-client:$SHA
kubectl set image deployments/server-deployment server=jhasangjekaj/multi-clie:$SHA
kubectl set image deployments/worker-deployment worker=jhasangjekaj/multi-worker:$SHA