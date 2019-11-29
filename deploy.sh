docker build -t gokhankiziltepe/multi-client:latest -t gokhankiziltepe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gokhankiziltepe/multi-server:latest -t gokhankiziltepe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gokhankiziltepe/multi-worker:latest -t gokhankiziltepe/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gokhankiziltepe/multi-client:latest
docker push gokhankiziltepe/multi-server:latest
docker push gokhankiziltepe/multi-worker:latest
docker push gokhankiziltepe/multi-client:$SHA
docker push gokhankiziltepe/multi-server:$SHA
docker push gokhankiziltepe/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=gokhankiziltepe/multi-client:$SHA
kubectl set image deployments/server-deployment server=gokhankiziltepe/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gokhankiziltepe/multi-worker:$SHA