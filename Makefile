build_flags = GO111MODULE=on GOOS=linux GOARCH=amd64

build: gomodgen
	env $(build_flags) go build -ldflags="-s -w" -o bin/api-authorizer 		github.com/smeny-codurance/aws-vpn/cmd/lambda-api-authorizer
	env $(build_flags) go build -ldflags="-s -w" -o bin/api-client 			github.com/smeny-codurance/aws-vpn/cmd/lambda-api-client
	env $(build_flags) go build -ldflags="-s -w" -o bin/api-server 			github.com/smeny-codurance/aws-vpn/cmd/lambda-api-server
	env $(build_flags) go build -ldflags="-s -w" -o bin/cert-stream 			github.com/smeny-codurance/aws-vpn/cmd/lambda-cert-stream
	env $(build_flags) go build -ldflags="-s -w" -o bin/revocation-notifier 	github.com/smeny-codurance/aws-vpn/cmd/lambda-revocation-notifier
	env $(build_flags) go build -ldflags="-s -w" -o bin/rotate-ca 				github.com/smeny-codurance/aws-vpn/cmd/lambda-rotate-ca
	env $(build_flags) go build -ldflags="-s -w" -o bin/ovpn-helper 			github.com/smeny-codurance/aws-vpn/cmd/ovpn-helper
clean:
	rm -rf ./bin ./vendor Gopkg.lock

gomodgen:
	chmod u+x gomod.sh
	./gomod.sh
