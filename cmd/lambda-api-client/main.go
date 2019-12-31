package main

import (
	"net/http"
	"os"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/awslabs/aws-lambda-go-api-proxy/gorillamux"
	clientapi "github.com/smeny-codurance/aws-vpn/pkg/api/client"
	log "github.com/sirupsen/logrus"
)

func init() {
	if os.Getenv("DEBUG") == "true" {
		log.SetLevel(log.DebugLevel)
	}
	log.SetFormatter(&log.JSONFormatter{
		TimestampFormat: time.RFC3339Nano,
		FieldMap: log.FieldMap{
			log.FieldKeyTime: "@timestamp",
		},
	})
}

func main() {
	router := clientapi.NewRouter()
	if _, ok := os.LookupEnv("AWS_LAMBDA_FUNCTION_NAME"); ok {
		adapter := gorillamux.New(router)
		adapter.StripBasePath("/api/client")
		lambda.Start(adapter.Proxy)
		return
	}

	if err := http.ListenAndServe("localhost:5000", router); err != nil {
		log.WithError(err).Fatal("Error serving")
	}
}
