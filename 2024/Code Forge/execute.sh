curl -L -O https://go.dev/dl/go1.25.4.linux-amd64.tar.gz

sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xf go1.25.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
go version
mkdir out
go build -o out/blade src/script.go