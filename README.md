gke-training
===

1. set PROJECT_ID
```
$ export PROJECT_ID=gke-training-xxxxx
```

2. create clusters
```
$ gcloud container clusters create gke-training \
--zone asia-northeast1-a \
--additional-zones asia-northeast1-b,asia-northeast1-c \
--num-nodes 1 \
--disk-size 20 \
--image-type COS \
--machine-type n1-standard-1 \
--cluster-version 1.8.6-gke.0
```

3. run deploy
```
$ ./deploy.sh 0.0.1
```

4. clean
```
$ kubectl delete service gke-training
$ kubectl delete deployment gke-training
$ gcloud container clusters delete gke-training
```
