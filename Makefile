.PHONY: run deploy

all: run

run: server/*.go
	gcloud preview app run server/ --project=inawordfm

deploy:
	git push
	gcloud preview app deploy . --project=inawordfm

update:
	goapp get -v -u ...
